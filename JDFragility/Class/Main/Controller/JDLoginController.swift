//
//  JDLoginController.swift
//  JDFragility
//
//  Created by apple on 2020/12/28.
//

import UIKit
import AdSupport
class JDLoginController: JDBaseViewController {

    @IBOutlet weak var telF: UITextField!
    @IBOutlet weak var vbg: UIView!
    
    @IBOutlet weak var addUD: UIButton!
    @IBOutlet weak var yzmF: UITextField!
    
    @IBOutlet weak var isSedtedBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var yonghuBtn: UIButton!
    @IBOutlet weak var yinseBtn: UIButton!
//    override func viewWillAppear(_ animated: Bool) {
//          super.viewWillAppear(animated)
// 
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//  
//      }
    override func viewDidLoad() {
        super.viewDidLoad()
//        https://www.jianshu.com/u/1e9554bab9b3
        navigationController?.setNavigationBarHidden(true, animated: false)
        loginBtn.layer.cornerRadius=10;
        addUD.layer.cornerRadius=10;
        loginBtn.addTarget(self, action: #selector(loginClick), for: .touchUpInside)
//          sendCodeBtn.addTarget(self, action: #selector(buttonClick(button01:)), for: .touchUpInside)
//        sendCodeBtn.addTarget(self, action: #selector(buttonClick (button01:)), for: .touchUpInside)

//        let names = ["小明","小红","小张","小白"]
//        for i in 0..<3 {
//            print(names[i])
//        }
//        names.forEach { (i) in
//            print(i)
//        }
        /// stride to (不包含)
//        for index in stride(from: 1, to: 4, by: 1) {
//           print(index)
//        }

        // stride through (包含)
//        for index in stride(from: 0, through: 4, by: 2) {
//           print(index)
//        }
        vbg.cornerRadius(corners: [UIRectCorner.bottomRight,UIRectCorner.topRight] , radius: 4)
        let vv = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        vv.cornerRadius(corners: [UIRectCorner.bottomLeft,UIRectCorner.topLeft] , radius: 4)
        
             let searchImageView = UIImageView(image: UIImage(named: "ti"))
             searchImageView.backgroundColor = UIColor.k_colorWith(hexStr: "DED9D8")
             searchImageView.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        searchImageView.contentMode = .scaleAspectFill
        searchImageView.center = vv.center
        vv.addSubview(searchImageView)
             self.telF.leftView = vv
             self.telF.leftViewMode = .always
        
        
        let vv1 = UIView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
        vv1.cornerRadius(corners: [UIRectCorner.bottomLeft,UIRectCorner.topLeft] , radius: 4)
             let searchImageView1 = UIImageView(image: UIImage(named: "mi"))
             searchImageView1.backgroundColor = UIColor.k_colorWith(hexStr: "DED9D8")
             searchImageView1.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        searchImageView1.contentMode = .scaleAspectFit
        searchImageView1.center = vv1.center
        vv1.addSubview(searchImageView1)
             self.yzmF.leftView = vv1
             self.yzmF.leftViewMode = .always
        
        
        
        addUD.addAction { (_) in
            let adId = ASIdentifierManager.shared().advertisingIdentifier.uuidString
//                ASIdentifierManager.shared().advertisingIdentifier.uuidString
            print(adId)
            
            JXTAlertView.show(withTitle: "备注", message: "") { (title) in
                print(title)
                if title.length > 0{
                let params = ["cfdIPadName": title ?? "" ,"cfdEquipment":kUUID ?? ""];
                NetManager.ShareInstance.postWith(url: "api/IPad/IPadAddGrandIpad", params: params) { (dic) in
                    print(dic)
                    NHMBProgressHud.showSuccesshTips(message: "绑定成功！")
                } error: { (error) in
                    
                }
                }
            }
        }
        isSedtedBtn.addAction { (btn) in
            btn.isSelected = !btn.isSelected
        }
        yonghuBtn.addAction { (_) in
            let webView = JDwebController()
            webView.url = "http://qianmeitest.feicuisoft.com/Agreement.htm"
//            webView.titles.text = "用户协议"
            self.navigationController?.pushViewController(webView, animated: true)
       
        }
        yinseBtn.addAction { (_) in
            let webView = JDwebController()
            webView.url = "http://qianmeitest.feicuisoft.com/Privacy.htm"
//            webView.titles.text = "隐私协议"
            self.navigationController?.pushViewController(webView, animated: true)
        }
    }

    @objc func loginClick()  {
 
        if isSedtedBtn.isSelected == false {
            NHMBProgressHud.showErrorMessage(message: "请阅读并同意用户协议和隐私协议")
            return
        }
        
        if telF.text?.length==0  {
            NHMBProgressHud.showErrorMessage(message: "请输入账户")
            return
        }
        if yzmF.text?.length==0  {
            NHMBProgressHud.showErrorMessage(message: "请输入密码")
            return
        }
        NHMBProgressHud.showLoadingHudView(message: "登录中。。。")
 
        let params = ["cfdUserName": telF.text ?? "",
                      "cfdPassWord": yzmF.text ?? "","cfdEquipment":kUUID ?? ""]
        NetManager.ShareInstance.postWith(url: "api/IPad/IPadLogin", params:params ) { (dic) in
            print(dic)
            NHMBProgressHud.hideHud()
            NHMBProgressHud.showSuccesshTips(message: "登录成功！")
            let login = JDUserInfo.deserialize(from: dic as? Dictionary)
            
            let userDefault = UserDefaults.standard
            userDefault.set(login?.cfdRealName, forKey: "cfdRealName")
            userDefault.set(login?.Ticket, forKey: "Ticket")
            userDefault.set(login?.cfdEmployeeId, forKey: "cfdEmployeeId")
            userDefault.set(login?.cfdEmployeeName, forKey: "cfdEmployeeName")
            userDefault.set(login?.cfdFendianId, forKey: "cfdFendianId")
            userDefault.set(login?.cfdLevelID, forKey: "cfdLevelID")
            userDefault.set(login?.cfdFendianName, forKey: "cfdFendianName")
            
            Kwindow.window?.rootViewController = JDNavViewController(rootViewController: JDMainController())
        } error: { (error) in
            NHMBProgressHud.hideHud()
            NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
        }

        
        
      }

//    @objc func aaa(but:UIButton) {
//        but.isSelected=true
//       print("你点击了我这个按钮方法buttonClick2(buttonMy:)");
//        but.setTitle("60", for: .selected)
//        LSTTimer.addMinuteTimer(forTime: 60) { (_, _, _, second:String, ms:String) in
//            print(second)
//            but.setTitle(second, for: .selected)
//        }
//
//      }
   

}
