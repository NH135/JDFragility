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
    
   
    
    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var rightTableView: UITableView!
    @IBOutlet weak var shifuML: UILabel!
    @IBOutlet weak var sureB: UIButton!
    @IBOutlet weak var coseB: UIButton!
    @IBOutlet weak var yhjTableView: UITableView!
    @IBOutlet weak var contenView: UIView!
    
    var isYf = false
    @IBOutlet weak var contenL: UIButton!
    var cfdBusListGUID : String?
    var memberModel : MemberDetailModel?
    var jiesuanModel : JDjiesuanModel?
    var allMoeny : Int = 0
    var yhjMoeny : Int = 0
    var payAllArr = [String]()
    var textArr = [UITextField]()
    var yhjArr = [JDhuiyuanDetail]()
    var setedyhjArr = [JDhuiyuanDetail]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "课程结帐"
        view.backgroundColor=UIColor.k_colorWith(hexStr: "f8f8f8")
        setletfUI()
        setrightUI()
        setcontenUI()
        setData()
        if isYf == true {
            title = "预付款课程结帐"
            yuB.isUserInteractionEnabled = false
        }
    }
    
    @IBAction func showYhjBt() {
        contenView.isHidden = true
    }
    
}

extension JDSettlementController:UITextFieldDelegate{
    func setData()  {
        NHMBProgressHud.showLoadingHudView(message: "加载中～～")
        NetManager.ShareInstance.getWith(url:"api/IPad/IPadQueryPayMode", params: nil) { (arr) in
 
            guard let payArr = arr as? [[String:Any]] else{return}
            var payList =  payArr.kj.modelArray(payModel.self)
            var yue = payModel()
            yue.cfdPayMode = "余额"
            payList.append(yue)
            self.addPayType(list: payList)
        } error: { (error) in
            NHMBProgressHud.hideHud()
            NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
        }
        
//
         
        let params = ["cfdBusListGUID":cfdBusListGUID ?? "" ]
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryBusListBySave", params: params as [String : Any]) { (dic) in
            NHMBProgressHud.hideHud()
            guard let dict = dic as? [String : Any] else{
                return
            }
            self.jiesuanModel = dict.kj.model(JDjiesuanModel.self)

            self.ewmL.image = self.jiesuanModel?.CodeMsg.cfdCodeMsgId?.k_createQRCode()
            
            if self.isYf{
//                let yingfu = (self.jiesuanModel?.BusList.ffdBusMoney ?? 0) - (self.jiesuanModel?.BusList.ffdArrear ?? 0)
                
                self.fuML.text = "应付：¥\(self.jiesuanModel?.BusList.ffdArrear ?? 0)"
            }else{
                self.fuML.text = "应付：¥\(self.jiesuanModel?.BusList.ffdBusMoney ?? 0)"
            }
            
         

            self.rightTableView.reloadData()
        } error: { (error) in
            NHMBProgressHud.hideHud()
            NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
         
        }
        //        获取优惠卷
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryTokenList", params: ["cfdMemberId":memberModel?.cfdMemberId ?? "","cfdBusListGUID":self.cfdBusListGUID ?? "" ] as [String : Any]) { (dic) in
            print("优惠卷\(dic)")
            
            if let arr = dic as? [[String : Any]] {
                self.yhjArr  = arr.kj.modelArray(JDhuiyuanDetail.self)
            }
            self.yhjTableView.reloadData()
        } error: { (error) in
            NHMBProgressHud.hideHud()
            NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
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
           
            if item.cfdPayMode == "余额" {
                btn.imageEdgeInsets = UIEdgeInsets(top: 12, left: -30, bottom: 12, right: 10)
                btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -70, bottom: 0, right: 0)
            }else{
                btn.imageEdgeInsets = UIEdgeInsets(top: 12, left: -70, bottom: 12, right: 10)
                btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -140, bottom: 0, right: 0)
            }
            btn.imageView?.contentMode = .scaleAspectFit
//            btn.contentHorizontalAlignment = .left
            btn.kf.setImage(with: URL(string: item.cfdImgSrc ?? ""), for: .normal, placeholder: UIImage(named: "yue"), options: nil, progressBlock: nil, completionHandler: nil)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.isUserInteractionEnabled = false
//            btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
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
            allMoeny = 0
//            allMoeny += yhjMoeny
            for (_,textF) in textArr.enumerated() {
                
                if textF.text?.k_isNumber == true {
                    allMoeny  = allMoeny + Int(textF.text ?? "0")!
                }
            }
            shifuML.text = "实付金额：¥\(allMoeny)"
            shifuML.wl_changeColor(withTextColor: UIColor.black, changeText: "实付金额：")
            
            if allMoeny >= (self.jiesuanModel?.BusList.ffdBusMoney  ?? 0 - yhjMoeny)   {
                self.wanB.isEnabled = false
                self.yuB.isEnabled = true
            }
            if allMoeny > (self.jiesuanModel?.BusList.ffdBusMoney  ?? 0 - yhjMoeny)   {
                NHMBProgressHud.showErrorMessage(message: "您输入的金额大于了应付金额")
            }
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


}

extension JDSettlementController{
    func setletfUI()  {
        iconImagV.cornerRadius(radius: 40)
        nameL.text = memberModel?.cfdMemberName
        telL.text = memberModel?.cfdMoTel
        lastML.text = "当前余额：\(memberModel?.ffdBalance ?? "0")"
        yhjB.cornerRadius(radius: 6)
        iconImagV.setHeaderImageUrl(url: memberModel?.cfdPhoto ?? "")
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
        shifuML.wl_changeColor(withTextColor: UIColor.black, changeText: "实付金额：")
        //        确定付款
        
        
        sureB.addAction { [self] (_) in
            if self.wanB.isEnabled == false{
                allMoeny += yhjMoeny
                if self.isYf {
//                    let yingf = (self.jiesuanModel?.BusList.ffdBusMoney ?? 0) - (self.jiesuanModel?.BusList.ffdArrear ?? 0)
                    
                    if allMoeny < self.jiesuanModel?.BusList.ffdArrear ?? 0    {
                        NHMBProgressHud.showErrorMessage(message: "输入的金额小于应付金额")
                        allMoeny -= yhjMoeny
                        return
                    }
                    if allMoeny >  self.jiesuanModel?.BusList.ffdArrear ?? 0   {
                        NHMBProgressHud.showErrorMessage(message: "您输入的金额大于了应付金额")
                        allMoeny -= yhjMoeny
                        return
                    }
                    
                }else{
                    if allMoeny < self.jiesuanModel?.BusList.ffdBusMoney ?? 0    {
                        NHMBProgressHud.showErrorMessage(message: "您选择了完款，但您输入的金额小于应付金额")
                        allMoeny -= yhjMoeny
                        return
                    }
                    if allMoeny >  self.jiesuanModel?.BusList.ffdBusMoney ?? 0   {
                        NHMBProgressHud.showErrorMessage(message: "您输入的金额大于了应付金额")
                        allMoeny -= yhjMoeny
                        return
                    }
                }
                
              
            }
            if self.yuB.isEnabled == false{
            if allMoeny == 0{
                NHMBProgressHud.showErrorMessage(message: "请输入支付金额")
                allMoeny -= yhjMoeny
                return
            }
            }
            var moneyArr = [payModel]()
            var ffdMemberBalance : String?
            
            for (_, item) in self.textArr.enumerated(){
                if item.tag == 99 {
                    ffdMemberBalance = item.text ?? ""
                }else{
                    if item.text?.isEmpty == false {
                        var pmodel = payModel()
                        pmodel.ifdId = item.tag;
                        pmodel.ffdIncome = item.text ?? ""
                        moneyArr.append(pmodel)
                    }
                
                }
            }
//
            
            var   payType = "true"
            if yuB.isEnabled == false{
                payType = "false"
            }
            NHMBProgressHud.showLoadingHudView(message: "结帐中～～")
            let params = ["cfdBusListGUID":self.cfdBusListGUID ?? "","ffdMemberBalance":ffdMemberBalance ?? "","cfdTokeStr":setedyhjArr.kj.JSONString() ,"ifdType":payType,"cfdCaiWustr":moneyArr.kj.JSONString(),"isRest":self.jiesuanModel?.isRest ?? ""] as [String : Any]
//            //            ffdMemberBalance 支付金额。 cfdTokeStr 优惠卷 ifdType true完整 false预付
            NetManager.ShareInstance.postWith(url: "api/IPad/IPadPayBusList", params: params) { (dic) in
                print("购买课程支付结果\(dic)")
                NHMBProgressHud.hideHud()
                NHMBProgressHud.showErrorMessage(message: "支付成功啦～")
                if dic["ifdJump"] as? Bool == true{
                    let save =  JDsaveKCController()
                    save.cfdBusListGUID = dic["cfdBusListGUID"] as? String ?? ""
 
                    self.navigationController?.ymPushViewController(save, removeSelf: true, animated: true)
                }else{
                    self.navigationController?.popViewController(animated: true)
                }
                
            } error: { (error) in
                allMoeny -= yhjMoeny
                NHMBProgressHud.hideHud()
                NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
            }
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
            
            if  self.yuB.isEnabled == true{
            
//            NHMBProgressHud.showErrorMessage(message: "暂无优惠卷")
            self.contenView.isHidden = false;
                
            }else{
                NHMBProgressHud.showErrorMessage(message: "预付款不能使用优惠卷")
            }
            
        }
        yhjTableView.delegate = self
        yhjTableView.dataSource = self
        yhjTableView.k_registerCell(cls: JDkechengYHJCell.self)
        
        

    }
}


extension JDSettlementController:jiezhangYhjSetedDelegate{
    func jzyhj(isEnd: Bool, model: JDhuiyuanDetail?) {
        print("\(isEnd)====\(String(describing: model))")
        if isEnd == true {
            setedyhjArr.append(model ?? JDhuiyuanDetail())
        }else{
            for (index,m) in setedyhjArr.enumerated() {
                if m.cfdTokenCode == model?.cfdTokenCode {
                    setedyhjArr.remove(at: index)
                    break;
                }
            }
      
        }
        let params = ["cfdBusListGUID":cfdBusListGUID ?? "" ,"cfdTokeStr":setedyhjArr.kj.JSONString()]
        NetManager.ShareInstance.postWith(url: "api/IPad/IPadUseToken", params: params) { (dic) in
            print(dic)
            
//            self.fuML.text = "应付：¥\( String(describing: dic["SuppMoney"] ?? "0" ) ) 优惠劵抵扣：¥\(String(describing: dic["DiscountMoney"] ?? "0"))"
            if let payDic = dic as? [String:Any] {
                self.fuML.text = "应付：¥\(payDic["SuppMoney"] ?? "0" ) "
//                let yhjMonys =  payDic["DiscountMoney"]
                self.yhjMoeny = payDic["DiscountMoney"] as! Int
//                self.yhjMoeny = Int(payDic["DiscountMoney"] ?? 0)
                self.yhjL.text = "优惠劵抵扣：¥\( payDic["DiscountMoney"] ?? "0")"
                
                self.allMoeny = 0

                for (_,textF) in self.textArr.enumerated() {
                    
                    if textF.text?.k_isNumber == true {
                        self.allMoeny  = self.allMoeny + Int(textF.text ?? "0")!
                    }
                }
                
            }
        
            
            
         
        } error: { (err) in
            print(err)
        }

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == rightTableView {
            return 110
        }else{
            return 90
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == yhjTableView {
            return self.yhjArr.count;
        }else if tableView == rightTableView {
            return self.jiesuanModel?.MCList.count ?? 0
        }else{
            return 10}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == yhjTableView {
            let cell = tableView.k_dequeueReusableCell(cls: JDkechengYHJCell.self, indexPath: indexPath)
            cell.kcYhjModel = self.yhjArr[indexPath.row]
            cell.delegate = self
            cell.selectionStyle = .none
            return cell
            
        }else if tableView == rightTableView {
            let cell = tableView.k_dequeueReusableCell(cls: JDCourseshopingCell.self, indexPath: indexPath)
            cell.jiesuanModel = self.jiesuanModel?.MCList[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
        return UITableViewCell()
    }
 
}
