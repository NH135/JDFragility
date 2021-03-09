//
//  JDCZView.swift
//  JDFragility
//
//  Created by apple on 2021/3/1.
//

import UIKit
 import IQKeyboardManager
class JDCZView: UIView {

    
    @IBOutlet weak var iconI: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var lastMoneyL: UILabel!
    @IBOutlet weak var mendianL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var MoneyL: UILabel!
    @IBOutlet weak var payV: UIView!
    @IBOutlet weak var sureB: UIButton!
    @IBOutlet weak var closeBtn: UIButton!

    
    var allMoeny : Int = 0
    var payAllArr = [String]()
    var textArr = [UITextField]()
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        sureB.cornerRadius(radius: 23)
        closeBtn.cornerRadius(radius: 23)
        
//        NHMBProgressHud.showLoadingHudView(message: "加载中～～")
        NetManager.ShareInstance.getWith(url:"api/IPad/IPadQueryPayMode", params: nil) { (arr) in
            NHMBProgressHud.hideHud()
            guard let payArr = arr as? [[String:Any]] else{return}
            let payList =  payArr.kj.modelArray(payModel.self)
            self.addPayType(list: payList)
        } error: { (error) in
            NHMBProgressHud.hideHud()
            NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
        }
        
        
    }
    
    func addPayType(list:[payModel]) {
        
        let width = Int((kScreenWidth-300)/2)
        let height = 50
        for (index ,item) in list.enumerated() {
            let vv = UIView(frame: CGRect(x: index % 2 * width, y: index / 2 * (height+10), width: width, height: height))
            payV.addSubview(vv)
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
            payType.inputAccessoryView = UIView()
            payType.placeholder = "请输入\(item.cfdPayMode ?? "")金额"
            payType.delegate = self
            payType.tag = item.ifdId ?? 99
            payType.borderStyle = .roundedRect
            payType.keyboardType = .numberPad
            vv.addSubview(payType)
            textArr.append(payType)
        }
    }
   


}
extension JDCZView:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        allMoeny = 0
        for (_,textF) in textArr.enumerated() {
            
            if textF.text?.k_isNumber == true {
                allMoeny  = allMoeny + Int(textF.text ?? "0")!
            }
        }
        print("实付金额：\(allMoeny)")
        MoneyL.text = "充值金额：¥\(allMoeny)"
//        shifuML.wl_changeColor(withTextColor: UIColor.black, changeText: "实付金额：")
//
//        if allMoeny >=  self.jiesuanModel?.BusList.ffdBusMoney ?? 0   {
//            self.wanB.isEnabled = false
//            self.yuB.isEnabled = true
//        }
//        if allMoeny >  self.jiesuanModel?.BusList.ffdBusMoney ?? 0   {
//            NHMBProgressHud.showErrorMessage(message: "您输入的金额大于了应付金额")
//        }
    }
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    guard textField.text?.length != 0 else {
        return false
    }
    
    guard textField.text?.k_isNumber == true else {
        NHMBProgressHud.showErrorMessage(message: "只能输入数字，请重新输入")
        textField.text = ""
        return false
    }
    return true
}
}
