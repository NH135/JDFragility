//
//  JDSettlementController.swift
//  JDFragility
//
//  Created by nh on 2021/1/12.
//

import UIKit

class JDSettlementController: JDBaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var iconImagV: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var telL: UILabel!
    @IBOutlet weak var lastML: UILabel!
    @IBOutlet weak var mdL: UILabel!
    @IBOutlet weak var ewmL: UIImageView!
    @IBOutlet weak var fuML: UILabel!
    @IBOutlet weak var wanB: UIButton!
    @IBOutlet weak var yuB: UIButton!
    @IBOutlet weak var yhjB: UIButton!
    @IBOutlet weak var yhjL: UILabel!
    
    var memberModel : MemberDetailModel?
    
    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var rightTableView: UITableView!
    @IBOutlet weak var shifuML: UILabel!
    @IBOutlet weak var sureB: UIButton!
    @IBOutlet weak var coseB: UIButton!
    @IBOutlet weak var yhjTableView: UITableView!
    @IBOutlet weak var contenView: UIView!
    var lastSelectIndex : IndexPath?
    var selectIndexs = Array<Any>()
    var isMore : Bool = false
    @IBOutlet weak var contenL: UILabel!
    var cfdBusListGUID : String?
    
    var jiesuanModel : JDjiesuanModel?
    var allMoeny : Int = 0
    var payAllArr = [String]()
    var textArr = [UITextField]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor=UIColor.k_colorWith(hexStr: "f8f8f8")
        
        
        setletfUI()
        setrightUI()
        setcontenUI()
        setData()
    }
    
    @IBAction func showYhjBt() {
        contenView.isHidden = true
    }
    
    
    
    
    
}

extension JDSettlementController:UITextFieldDelegate{
    func setData()  {
        NetManager.ShareInstance.getWith(url:"api/IPad/IPadQueryPayMode", params: nil) { (arr) in
            print("支付方式：\(arr)")
            guard let payArr = arr as? [[String:Any]] else{return}
            var payList =  payArr.kj.modelArray(payModel.self)
            var yue = payModel()
            yue.cfdPayMode = "余额"
            payList.append(yue)
            self.addPayType(list: payList)
        } error: { (error) in
            
        }
        
//
//        let params = ["cfdBusListGUID":cfdBusListGUID ?? "" ]
//        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryBusListBySave", params: params as [String : Any]) { (dic) in
//
//            guard let dict = dic as? [String : Any] else{
//                return
//            }
//            self.jiesuanModel = dict.kj.model(JDjiesuanModel.self)
//
//            self.ewmL.image = self.jiesuanModel?.CodeMsg.cfdCodeMsgId?.k_createQRCode()
//            self.fuML.text = "应付：\(self.jiesuanModel?.BusList.ffdBusMoney ?? "0")"
//
//            self.rightTableView.reloadData()
//        } error: { (error) in
//            print(error)
//        }
        //        获取优惠卷
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryTokenList", params: ["cfdMemberId":memberModel?.cfdMemberId ?? "" ] as [String : Any]) { (dic) in
            print("优惠卷\(dic)")
            //            guard let dict = dic as? [[String : Any]] else{
            //                return
            //            }
            //            self.jiesuanModel = dict.kj.modelArray(JDjiesuanModel.self)
            
            
            //            self.rightTableView.reloadData()
        } error: { (error) in
            print(error)
        }
    }
    func addPayType(list:[payModel]) {
        
        let width = (Int(view.width)-300)/2
        let height = 50
        for (index ,item) in list.enumerated() {
            let vv = UIView(frame: CGRect(x: index % 2 * width, y: index / 2 * (height+10), width: width, height: height))
            payView.addSubview(vv)
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 120, height: 50))
            btn.setTitle(item.cfdPayMode, for: .normal)
            
            btn.setImage(UIImage(named: item.cfdPayMode ?? ""), for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.isUserInteractionEnabled = false
            btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
            vv.addSubview(btn)
            
            let payType = UITextField(frame: CGRect(x: 130, y: 0, width: width-150, height: 50))
            payType.placeholder = "请输入\(item.cfdPayMode ?? "")金额"
            payType.delegate = self
            payType.tag = item.ifdId ?? 99
            payType.borderStyle = .roundedRect
            payType.keyboardType = .numberPad
            vv.addSubview(payType)
            textArr.append(payType)
        }
    }
        func textFieldDidEndEditing(_ textField: UITextField) {
            print(textField.text ?? "")
        }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard textField.text?.k_isNumber == true else {
            NHMBProgressHud.showErrorMessage(message: "只能输入数字，请重新输入")
            textField.text = ""
            return false
        }
        return true
    }

    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//         if textField.placeholder?.containsIgnoringCase(find: "支付宝") == true  {
//            if textField.text?.k_isEmpty == false{
//                payAllArr.append("\(textField.placeholder ?? ""): \(textField.text ?? "")")
//            }else{
//                for (index,item) in payAllArr.enumerated() {
//                    if item.containsIgnoringCase(find: "支付宝") == true {
//                        payAllArr.remove(at: index)
//                    }
//                }
//            }
//        }else  if textField.placeholder?.containsIgnoringCase(find: "银联") == true  {
//            if textField.text?.k_isEmpty == false{
//                payAllArr.append("\(textField.placeholder ?? ""): \(textField.text ?? "")")
//            }else{
//                for (index,item) in payAllArr.enumerated() {
//                    if item.containsIgnoringCase(find: "银联") == true {
//                        payAllArr.remove(at: index)
//                    }
//                }
//            }
//        }else  if textField.placeholder?.containsIgnoringCase(find: "微信") == true  {
//            if textField.text?.k_isEmpty == false{
//                payAllArr.append("\(textField.placeholder ?? ""): \(textField.text ?? "")")
//            }else{
//                for (index,item) in payAllArr.enumerated() {
//                    if item.containsIgnoringCase(find: "微信") == true {
//                        payAllArr.remove(at: index)
//                    }
//                }
//            }
//        }else  if textField.placeholder?.containsIgnoringCase(find: "现金") == true  {
//            if textField.text?.k_isEmpty == false{
//                payAllArr.append("\(textField.placeholder ?? ""): \(textField.text ?? "")")
//            }else{
//                for (index,item) in payAllArr.enumerated() {
//                    if item.containsIgnoringCase(find: "现金") == true {
//                        payAllArr.remove(at: index)
//                    }
//                }
//            }
//        }else  if textField.placeholder?.containsIgnoringCase(find: "余额") == true  {
//            if textField.text?.k_isEmpty == false{
//                payAllArr.append("\(textField.placeholder ?? ""): \(textField.text ?? "")")
//            }else{
//                for (index,item) in payAllArr.enumerated() {
//                    if item.containsIgnoringCase(find: "余额") == true {
//                        payAllArr.remove(at: index)
//                    }
//                }
//            }
//        }
//    }
}

extension JDSettlementController{
    func setletfUI()  {
        
        nameL.text = memberModel?.cfdMemberName
        telL.text = memberModel?.cfdMoTel
        lastML.text = "当前余额：\(memberModel?.ffdBalance ?? "0")"
        
        let cfdFendianName = UserDefaults.standard.string(forKey: "cfdFendianName") ?? ""
        mdL.text = "购买门店：\(cfdFendianName)"
        
        wanB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.yuB.isEnabled = true
        }
        
        yuB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.wanB.isEnabled = true
        }
    }
    
}

extension JDSettlementController{
    func setrightUI()  {
        rightTableView.tableFooterView = UIView()
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.k_registerCell(cls: JDCourseshopingCell.self)
        
        //        确定付款
        
        
        sureB.addAction { (_) in
//            var moneyArr = [payModel]()
//            var pmodel = payModel()
//            pmodel.ifdId = "1";
//            pmodel.ffdIncome = "1000"
//            moneyArr.append(pmodel)
//
//            let params = ["cfdBusListGUID":self.cfdBusListGUID ?? "","ffdMemberBalance":"34000","cfdTokeStr":"","ifdType":"true","cfdCaiWustr":moneyArr.kj.JSONString() ]
//            //            ffdMemberBalance 支付金额。 cfdTokeStr 优惠卷 ifdType true完整 false预付
//            NetManager.ShareInstance.postWith(url: "api/IPad/IPadPayBusList", params: params) { (dic) in
//                print("购买课程支付结果\(dic)")
//                NHMBProgressHud.showErrorMessage(message: "支付成功啦～")
//            } error: { (error) in
//                print(error)
//            }
//
            print(self.payAllArr)
        }
    }
    
}


extension JDSettlementController{
    
    func setcontenUI()  {
        contenL.cornerRadius(corners: [.topLeft ,.topRight], radius: 10)
        contenView.backgroundColor=UIColor.black.withAlphaComponent(0.3)
        coseB.addAction { (_) in
            self.contenView.isHidden = true
        }
      
        yhjB.addAction { (_) in
            self.contenView.isHidden = false
        }
        
        
        
        yhjTableView.delegate = self
        yhjTableView.dataSource = self
        yhjTableView.k_registerCell(cls: UITableViewCell.self)
        
        
        
    }

    
    
}


extension JDSettlementController{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == rightTableView {
            return 110
        }else{
            return 90
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == yhjTableView {
            return 20
        }else if tableView == rightTableView {
            return self.jiesuanModel?.MCList.count ?? 0
        }else{
            return 10}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == yhjTableView {
            let cell = tableView.k_dequeueReusableCell(cls: UITableViewCell.self, indexPath: indexPath)
            
            cell.textLabel?.text = "优惠卷\(indexPath.row)"
            if self.isMore == true {
                for index in selectIndexs {
                    if index as? IndexPath  == indexPath{
                        cell.accessoryType = .checkmark
                    }
                }
            }else{
                if lastSelectIndex == indexPath {
                    cell.accessoryType = .checkmark
                }else{
                    cell.accessoryView = .none
                }
            }
            return cell
            
        }else if tableView == rightTableView {
            let cell = tableView.k_dequeueReusableCell(cls: JDCourseshopingCell.self, indexPath: indexPath)
            cell.jiesuanModel = self.jiesuanModel?.MCList[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == yhjTableView {
            if self.isMore == true {
                let cell = tableView.cellForRow(at: indexPath)
                
                if  cell?.accessoryType == .checkmark  {
                    cell?.accessoryType = .none
                    for (index,item) in selectIndexs.enumerated() {
                        if item as? IndexPath == indexPath {
                            selectIndexs.remove(at: index)
                        }
                    }
                    
                }else{
                    cell?.accessoryType = .checkmark
                    selectIndexs.append(indexPath)
                }
                
            }else{
                if lastSelectIndex == nil {
                    lastSelectIndex = indexPath
                    let cell = tableView.cellForRow(at: indexPath)
                    cell?.accessoryType = .checkmark
                }else{
                    let celled = tableView.cellForRow(at: lastSelectIndex! )
                    celled?.accessoryType = .none
                    
                    lastSelectIndex = indexPath
                    let cell = tableView.cellForRow(at: indexPath)
                    cell?.accessoryType = .checkmark
                    
                    
                }
            }
            
        }
        
    }
}
