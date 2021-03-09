//
//  JDhuanKeSaveController.swift
//  JDFragility
//
//  Created by apple on 2021/2/7.
//

import UIKit
import Kingfisher
class JDhuanKeSaveController: JDBaseViewController,UITableViewDelegate,UITableViewDataSource, shopingcourseAddDelegate {
  
    
  
    @IBOutlet weak var diMoenyTf: UITextField!
    @IBOutlet weak var shifuML: UILabel!
    @IBOutlet weak var sureB: UIButton!
    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var yueL: UILabel!
    
    var allMoeny : Double = 0.0
    var yingMoeny : Double = 0.0
    var payAllArr = [String]()
    var textArr = [UITextField]()
    var TimeList = [JDGroupProjectModel]()
    var addList = [JDGroupProjectModel]()
    var shopingGroups = [JDGroupProjectModel]()
    var cfdMemberId  = String()
    var yueStr = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "选择需兑换的老课程"
        diMoenyTf.delegate = self
        leftTableView.delegate = self
        leftTableView.tableFooterView = UIView()
        leftTableView.dataSource = self
        leftTableView.k_registerCell(cls: JDCourseshopingCell.classForCoder())
        rightTableView.dataSource = self
        rightTableView.delegate = self
        rightTableView.k_registerCell(cls: JDCourseshopingCell.classForCoder())
        setletfUI()
        setrightUI()
        setData()
        yueL.text = yueStr.k_isEmpty == false ? "当前余额:¥"+yueStr : ""
        
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == rightTableView {
            return 110
        }else{
            return 90
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if tableView == rightTableView {
        
            return shopingGroups.count
        }else{
       
            return TimeList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       if tableView == rightTableView {
            let cell = tableView.k_dequeueReusableCell(cls: JDCourseshopingCell.self, indexPath: indexPath)
        cell.detaileModel = shopingGroups[indexPath.row]
        cell.selectionStyle = .none
            return cell
       }else{
        let cell = tableView.k_dequeueReusableCell(cls: JDCourseshopingCell.self, indexPath: indexPath)
    
        cell.delegate = self
        cell.huanModel = self.TimeList[indexPath.row]
        cell.selectionStyle = .none
        cell.selectionStyle = .none;
        return cell
       }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        
    }
    
    func huanaddjianCourse(type: Bool, model: JDGroupProjectModel) {
 
        
        if model.ifdChangeNumber! == 0 {
            addList.removeAll(where: { $0.cfdMemberCardGUID == model.cfdMemberCardGUID})
       }else if model.ifdChangeNumber! == 1 {
        addList.append(model)
       }else if model.ifdChangeNumber! > 1 {
        addList.removeAll(where: { $0.cfdMemberCardGUID == model.cfdMemberCardGUID})
        addList.append(model)
       }
        print(addList.count)
//        leftTableView.reloadData()
    }
    
    func shopingaddjianCourse(type: Bool, model: JDGroupModel) {
      
    }
}

extension JDhuanKeSaveController:UITextFieldDelegate{
    func setData()  {
        NHMBProgressHud.showLoadingHudView(message: "加载中～～")
        NetManager.ShareInstance.getWith(url:"api/IPad/IPadQueryPayMode", params: nil) { (arr) in
            NHMBProgressHud.hideHud()
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
        
     
    }
    
    func addPayType(list:[payModel]) {
        
        let width = (Int(view.width)-440)/2
        let height = 45
        for (index ,item) in list.enumerated() {
            let vv = UIView(frame: CGRect(x: index % 2 * width, y: index / 2 * (height+10), width: width, height: height))
            payView.addSubview(vv)
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: height))
            btn.setTitle(item.cfdPayMode, for: .normal)
            if item.cfdPayMode == "余额" {
                btn.imageEdgeInsets = UIEdgeInsets(top: 12, left: -30, bottom: 12, right: 10)
                btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -70, bottom: 0, right: 0)
            }else{
                btn.imageEdgeInsets = UIEdgeInsets(top: 12, left: -70, bottom: 12, right: 10)
                btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: -140, bottom: 0, right: 0)
            }
            btn.imageView?.contentMode = .scaleAspectFit
//            btn.setImage(UIImage(named: item.cfdImgSrc ?? ""), for: .normal)
            btn.kf.setImage(with: URL(string: item.cfdImgSrc ?? ""), for: .normal, placeholder: UIImage(named: "yue"), options: nil, progressBlock: nil, completionHandler: nil)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.isUserInteractionEnabled = false
          
            vv.addSubview(btn)
            
            let payType = UITextField(frame: CGRect(x: 100, y: 0, width: width-110, height: height))
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
        if textField == diMoenyTf {
             
            for item in shopingGroups {
                allMoeny += Double(item.ffdPrice ?? "0") ?? 0.0
                
            }
            shifuML.textColor = UIColor.k_colorWith(hexStr: "#FB6260")
             
            yingMoeny = allMoeny -  Double(diMoenyTf.text ?? "0")!
            shifuML.text = "应补金额：¥\(yingMoeny)"
            shifuML.wl_changeColor(withTextColor: UIColor.black, changeText: "应补金额：")
        }else{
            
            if yingMoeny == 0.0 {
                NHMBProgressHud.showErrorMessage(message: "请先输入抵扣金额")
                textField.text = ""
                return
            }
            yingMoeny = Double(diMoenyTf.text ?? "0") ?? 0.0
        for (_,textF) in textArr.enumerated() {
            
            if textF.text?.k_isNumber == true {
                yingMoeny  = yingMoeny + Double(textF.text ?? "0")!
            }
        }
            
            if allMoeny < yingMoeny {
                NHMBProgressHud.showErrorMessage(message: "实付金额大于应补今日，请重新输入")
                textField.text = ""
                return
            }
             
            
            
        shifuML.textColor = UIColor.k_colorWith(hexStr: "#FB6260")
            yingMoeny = allMoeny - yingMoeny
        shifuML.text = "应补金额：¥\(yingMoeny)"
        shifuML.wl_changeColor(withTextColor: UIColor.black, changeText: "应补金额：")
//
//        if allMoeny >= Int(self.jiesuanModel?.BusList.ffdBusMoney ?? "0") ?? 0   {
//            self.wanB.isEnabled = false
//            self.yuB.isEnabled = true
//        }
//        if allMoeny > Int(self.jiesuanModel?.BusList.ffdBusMoney ?? "0") ?? 0   {
//            NHMBProgressHud.showErrorMessage(message: "您输入的金额大于了应付金额")
//        }
            
        }
    }
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    if textField.text?.k_isNumber == false {
        textField.text = ""
        return false
    }
   
    return true
}


}
extension JDhuanKeSaveController{
    func setletfUI()  {
  
    }
    
}

extension JDhuanKeSaveController{
    func setrightUI()  {
        rightTableView.tableFooterView = UIView()
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.k_registerCell(cls: JDCourseshopingCell.self)
        shifuML.wl_changeColor(withTextColor: UIColor.black, changeText: "实付金额：")
        //        确定付款
        sureB.addAction { [self] (_) in
          
            guard self.addList.count != 0 else{
                NHMBProgressHud.showErrorMessage(message: "请选择左侧课程进行兑换！")
                return
            }
//            guard allMoeny != 0 else{
//                NHMBProgressHud.showErrorMessage(message: "请输入支付金额")
//                return
//            }
//
            guard yingMoeny == 0 else{
                
                NHMBProgressHud.showErrorMessage(message: "输入支付金额不符合")
                return
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
            let cfdEmployeeId = UserDefaults.standard.string(forKey: "cfdEmployeeId") ?? ""
            let cfdFendianId = UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""
            let params = ["cfdRefMemberTime":self.addList.kj.JSONString(),"cfdNewCourse":shopingGroups.kj.JSONString() ,"cfdCaiWustr":moneyArr.kj.JSONString() ,"cfdEmployeeId":cfdEmployeeId,"cfdMemberId":cfdMemberId,"cfdFendianId":cfdFendianId,"ffdMemberBalance":ffdMemberBalance ?? "","dfdExchangeAmount":self.diMoenyTf.text ?? ""]
            NHMBProgressHud.showLoadingHudView(message: "加载中～～")
////            //            ffdMemberBalance 支付金额。 cfdTokeStr 优惠卷 ifdType true完整 false预付
            NetManager.ShareInstance.postWith(url: "api/IPad/IPadAddChangeCourse", params: params) { (dic) in
                print("购买课程支付结果\(dic)")
                NHMBProgressHud.hideHud()
                NHMBProgressHud.showErrorMessage(message: "支付成功啦～")
             
                    self.navigationController?.popViewController(animated: true)
                 
            } error: { (error) in
                NHMBProgressHud.hideHud()
                NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
            }
        }
    }
    
}
 
