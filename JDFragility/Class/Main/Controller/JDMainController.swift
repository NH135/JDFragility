//
//  JDMainController.swift
//  JDFragility
//
//  Created by apple on 2020/12/30.
//

import UIKit

class JDMainController: JDBaseViewController {

    @IBOutlet weak var iconB: UIButton!
    @IBOutlet weak var yuyueBtn: UIButton!
    @IBOutlet weak var kechengBtn: UIButton!
    @IBOutlet weak var huiyuanBtn: UIButton!
    @IBOutlet weak var kaoqinBtn: UIButton!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var dianzhangBtn: UIButton!
    
    private var reserver:JDReservedController?
    private var member:JDMemberController?
    private var attendance:JDAttendanceController?
    private var management:JDManagementController?
    private var course:JDCourseController?
    
    var one :Bool = false
    var two :Bool = false
    var three :Bool = false
    var four :Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
 
                navigationController?.navigationBar.isHidden=true
  
      }
      override func viewWillDisappear(_ animated: Bool) {
          super.viewDidDisappear(animated)
                      navigationController?.navigationBar.isHidden=false
 
      }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="首页"
        iconB.hw_locationAdjust(buttonMode: .Top, spacing: 10)
        yuyueBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
        kechengBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
        huiyuanBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
        kaoqinBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
        dianzhangBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
     
        yuyueBtn.isEnabled=false
    
        clickAction()
        
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

      
     
      
        
        
  
       
//        self.addChild(self.member ?? UIViewController())
      
        
        
       
//        self.addChild(self.attendance ?? UIViewController())
    
        
        
        
      
//        self.addChild(self.management ?? UIViewController())
        
           
        
        func typeView(with type:NSInteger) {
            
            self.reserver?.view.isHidden=true;
            self.course?.view.isHidden=true;
            self.member?.view.isHidden=true;
            self.attendance?.view.isHidden=true;
            self.management?.view.isHidden=true;
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
                self.attendance?.view.isHidden=false;
                if three == false {
                    self.attendance = JDAttendanceController()
                    self.attendance?.view.frame=CGRect(x: 0, y: 0, width: kScreenWidth-100, height: kScreenHeight)
//                    self.attendance?.view.isHidden=true;
                    self.addChild(self.attendance ?? UIViewController())
                    rightView.addSubview(self.attendance?.view ?? UIView())
                    three = true
                }
            default:
                
                self.management?.view.isHidden=false;
                if four == false {
                    self.management = JDManagementController()
                    self.management?.view.frame=CGRect(x: 0, y: 0, width: kScreenWidth-100, height: kScreenHeight)
//                    self.management?.view.isHidden=true;
                    self.addChild(self.management ?? UIViewController())
                    rightView.addSubview(self.management?.view ?? UIView())
                    four = true
                }
            }
        }
        
        typeView(with: 1)
        
        yuyueBtn.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.kechengBtn.isEnabled = true
            self.huiyuanBtn.isEnabled = true
            self.kaoqinBtn.isEnabled = true
            self.dianzhangBtn.isEnabled = true
        typeView(with: 1)
        }
        
        kechengBtn.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.yuyueBtn.isEnabled = true
            self.huiyuanBtn.isEnabled = true
            self.kaoqinBtn.isEnabled = true
            self.dianzhangBtn.isEnabled = true
            typeView(with: 2)
        }
        
        
        huiyuanBtn.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.kechengBtn.isEnabled = true
            self.yuyueBtn.isEnabled = true
            self.kaoqinBtn.isEnabled = true
            self.dianzhangBtn.isEnabled = true
            typeView(with: 3)
        }
        
        
        kaoqinBtn.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.kechengBtn.isEnabled = true
            self.huiyuanBtn.isEnabled = true
            self.kechengBtn.isEnabled = true
            self.dianzhangBtn.isEnabled = true
            typeView(with: 4)
        }
        
        dianzhangBtn.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.kechengBtn.isEnabled = true
            self.huiyuanBtn.isEnabled = true
            self.kaoqinBtn.isEnabled = true
            self.huiyuanBtn.isEnabled = true
            typeView(with:5)
        }
    }
    
    
    
 
}
