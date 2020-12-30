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
    override func viewDidLoad() {
        super.viewDidLoad()
        title="首页"
        iconB.hw_locationAdjust(buttonMode: .Top, spacing: 10)
        yuyueBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
        kechengBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
        huiyuanBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
        kaoqinBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
        dianzhangBtn.hw_locationAdjust(buttonMode: .Top, spacing: 10)
//
//        yuyueBtn.isEnabled=false
        
        clickAction()
    }

 

}

 


extension JDMainController {
    
    
    /// 点击事件
    private func clickAction() {
        let view1 = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth-100, height: kScreenHeight))
        view1.isHidden=true;
        view1.backgroundColor=UIColor.red;
        rightView .addSubview(view1)
        
        let view2 = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth-100, height: kScreenHeight))
        view2.backgroundColor=UIColor.yellow;
        view2.isHidden=true;
        rightView .addSubview(view2)
        
        let view3 = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth-100, height: kScreenHeight))
        view3.backgroundColor=UIColor.orange;
        view3.isHidden=true;
        rightView .addSubview(view3)
        
        let view4 = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth-100, height: kScreenHeight))
        view4.backgroundColor=UIColor.blue;
        view4.isHidden=true;
        rightView .addSubview(view4)
        
        let view5 = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth-100, height: kScreenHeight))
        view5.backgroundColor=UIColor.purple;
        view5.isHidden=true;
        rightView .addSubview(view5)
        
          
        
        
        
       
        
        func typeView(with type:NSInteger) {
            
            view1.isHidden=true;
            view2.isHidden=true;
            view3.isHidden=true;
            view4.isHidden=true;
            view5.isHidden=true;
            switch type {
            case 1:
                view1.isHidden=false;
            case 2:
                view2.isHidden=false;
            case 3:
                view3.isHidden=false;
            case 4:
                view4.isHidden=false;
            default:
                view5.isHidden=false;
            }
        }
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
