//
//  JDMainController.swift
//  JDFragility
//
//  Created by apple on 2020/12/30.
//

import UIKit
import IQKeyboardManager
class JDMainController: JDBaseViewController {

    @IBOutlet weak var iconB: UIButton!
    @IBOutlet weak var yuyueBtn: UIButton!
    @IBOutlet weak var kechengBtn: UIButton!
    @IBOutlet weak var huiyuanBtn: UIButton!
//    @IBOutlet weak var kaoqinBtn: UIButton!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var dianzhangBtn: UIButton!
    
    private var reserver:JDReservedController?
    private var member:JDMemberController?
    private var attendance:JDAttendanceController?
    private var management:JDlingCarController?
    private var course:JDCourseController?
    
    private var shengling:JDlingCarController?
    private var huanke:JDhuanKeController?
    private var tuike:JDtuiKeController?
    
    
    var one :Bool = false
    var two :Bool = false
    var three :Bool = false
    var four :Bool = false
    var five :Bool = false
    var six :Bool = false

    
    @IBOutlet weak var closeB: UIButton!
    @IBOutlet weak var hiddenB: UIButton!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var mendianL: UILabel!
    @IBOutlet weak var versionL: UILabel!
    @IBOutlet weak var szBgV: UIView!
    
    @IBOutlet weak var outBtn: UIButton!
    @IBOutlet weak var huankBtn: UIButton!
    @IBOutlet weak var tuikBtn: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
 
        navigationController?.setNavigationBarHidden(true, animated: animated)
  
      }
      override func viewWillDisappear(_ animated: Bool) {
          super.viewDidDisappear(animated)
                      
        navigationController?.setNavigationBarHidden(false, animated: animated)
 
      }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="首页"
    
        iconB.hw_locationAdjust(buttonMode: .Top, spacing: 10)
        yuyueBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
        kechengBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
        huiyuanBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
        huankBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
                tuikBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
        dianzhangBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
     
        yuyueBtn.isEnabled=false
        
            iconB.setTitle(UserDefaults.standard.string(forKey: "cfdFendianName") ?? "", for: .normal)
        clickAction()
        
        setting();
        
    }
 
}

extension JDMainController {
    //设置
    private func setting() {
        iconB.addAction { (_) in
            self.szBgV.isHidden = false
        }
        hiddenB.addAction { (_) in
            self.szBgV.isHidden = true
        }
        closeB.addAction { (_) in
            self.szBgV.isHidden = true
        }
 
        nameL.text = "当前登陆：\( UserDefaults.standard.string(forKey: "cfdEmployeeName") ?? "")"
        mendianL.text = "当前门店：\(UserDefaults.standard.string(forKey: "cfdFendianName") ?? "")"
        versionL.text = "当前版本：V \(kAppVersion ?? 0)"
        outBtn.k_cornerRadius = 23
        outBtn.addAction { (_) in
            JXTAlertView.show(withTitle: "提示", message: "确定要退出吗？", cancelButtonTitle: "取消", otherButtonTitle: "确认") { (_) in
                
            } otherButtonBlock: { (index) in
                print(index)
                (UIApplication.shared.delegate as! AppDelegate).showWindowOutLogin()
            }
 
        }
    }
    
}


extension JDMainController {
     
    /// 点击事件
    private func clickAction() { 
        self.reserver = JDReservedController()
        self.reserver?.view.frame=CGRect(x: 0, y: 0, width: view.width-100, height: view.height)
        self.reserver?.view.isHidden=true;
        self.reserver?.view.backgroundColor=UIColor.red;
        self.addChild(self.reserver ?? UIViewController())
        rightView.addSubview(self.reserver?.view ?? UIView())

      
      
        
        func typeView(with type:NSInteger) {
            IQKeyboardManager.shared().isEnabled = true
            view.endEditing(true)
            self.reserver?.view.isHidden=true;
            self.course?.view.isHidden=true;
            self.member?.view.isHidden=true;
            self.attendance?.view.isHidden=true;
            self.management?.view.isHidden=true;
            self.tuike?.view.isHidden=true;
            self.huanke?.view.isHidden=true;
            switch type {
            case 1:
              
                self.reserver?.view.isHidden=false;
    
            case 2:
              
                self.course?.view.isHidden=false;
                
                if one == false {
                    self.course = JDCourseController()
                    self.course?.view.frame=CGRect(x: 0, y: 0, width: kScreenWidth-100, height: kScreenHeight)
//                    self.course?.view.isHidden=true;
                    self.addChild(self.course ?? UIViewController())
                    rightView.addSubview(self.course?.view ?? UIView())
                    one = true
                }
              
            case 3:
                self.member?.view.isHidden=false;
                if two == false {
                    self.member = JDMemberController()
                    self.member?.view.frame=CGRect(x: 0, y: 0, width: kScreenWidth-100, height: kScreenHeight)
//                    self.member?.view.isHidden=true;
                    self.addChild(self.member ?? UIViewController())
                    rightView.addSubview(self.member?.view ?? UIView())
                    two = true
                }
            case 4:
                
                self.management?.view.isHidden=false;
                if three == false {
                    self.management = JDlingCarController()
                    self.management?.view.frame=CGRect(x: 0, y: 0, width: kScreenWidth-100, height: kScreenHeight)
//                    self.management?.view.isHidden=true;
                    self.addChild(self.management ?? UIViewController())
                    rightView.addSubview(self.management?.view ?? UIView())
                    three = true
                }
            case 5:
                
                self.huanke?.view.isHidden=false;
                if four == false {
                    self.huanke = JDhuanKeController()
                    self.huanke?.view.frame=CGRect(x: 0, y: 0, width: kScreenWidth-100, height: kScreenHeight)
//                    self.management?.view.isHidden=true;
                    self.addChild(self.huanke ?? UIViewController())
                    rightView.addSubview(self.huanke?.view ?? UIView())
                    four = true
                }
                
                
            default:
                
                self.tuike?.view.isHidden=false;
                if five == false {
                    self.tuike = JDtuiKeController()
                    self.tuike?.view.frame=CGRect(x: 0, y: 0, width: kScreenWidth-100, height: kScreenHeight)
//                    self.management?.view.isHidden=true;
                    self.addChild(self.tuike ?? UIViewController())
                    rightView.addSubview(self.tuike?.view ?? UIView())
                    five = true
                }
            }
        }
        
        typeView(with: 1)
        
        yuyueBtn.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.kechengBtn.isEnabled = true
            self.huiyuanBtn.isEnabled = true
//            self.kaoqinBtn.isEnabled = true
            self.dianzhangBtn.isEnabled = true
            self.huankBtn.isEnabled = true;
            self.tuikBtn.isEnabled = true;
            
        typeView(with: 1)
        }
        
        kechengBtn.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.yuyueBtn.isEnabled = true
            self.huiyuanBtn.isEnabled = true
//            self.kaoqinBtn.isEnabled = true
            self.dianzhangBtn.isEnabled = true
            self.huankBtn.isEnabled = true;
            self.tuikBtn.isEnabled = true;
            
            typeView(with: 2)
        }
        
        
        huiyuanBtn.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.kechengBtn.isEnabled = true
            self.yuyueBtn.isEnabled = true
//            self.kaoqinBtn.isEnabled = true
            self.dianzhangBtn.isEnabled = true
            self.huankBtn.isEnabled = true;
            self.tuikBtn.isEnabled = true;
            
            typeView(with: 3)
        }
        
        
 
        
        dianzhangBtn.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.kechengBtn.isEnabled = true
            self.huiyuanBtn.isEnabled = true
//            self.kaoqinBtn.isEnabled = true
            self.yuyueBtn.isEnabled = true
            self.huankBtn.isEnabled = true;
            self.tuikBtn.isEnabled = true;

            typeView(with:4)
        }
        
        huankBtn.addAction { (btn:UIButton) in
                        btn.isEnabled=false
                        self.kechengBtn.isEnabled = true
                        self.huiyuanBtn.isEnabled = true
            //            self.kaoqinBtn.isEnabled = true
                        self.yuyueBtn.isEnabled = true
                        self.dianzhangBtn.isEnabled = true;
                        self.tuikBtn.isEnabled = true;
            typeView(with: 5)
        }
        tuikBtn.addAction { (btn:UIButton) in
                        btn.isEnabled=false
                        self.kechengBtn.isEnabled = true
                        self.huiyuanBtn.isEnabled = true
            //            self.kaoqinBtn.isEnabled = true
                        self.yuyueBtn.isEnabled = true
                        self.dianzhangBtn.isEnabled = true;
                        self.huankBtn.isEnabled = true;
            typeView(with: 6)
        }
        
    }
    
    
    
 
}
