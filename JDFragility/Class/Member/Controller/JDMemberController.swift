//
//  JDMemberController.swift
//  JDFragility
//
//  Created by apple on 2020/12/30.
//会员信息

import UIKit

class JDMemberController: JDBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let widthV = ( kScreenWidth-190)/2
        
        let leftView = UIView(frame: CGRect(x: 30, y: 30, width: widthV, height: kScreenHeight-60))
        
        leftView.backgroundColor=UIColor.yellow;
        leftView.centerY=view.centerY
        view.addSubview(leftView)
        
        let rightView = UIView(frame: CGRect(x: widthV+60, y: 30, width: widthV, height: kScreenHeight-60))
   
        rightView.backgroundColor=UIColor.red;
        view.addSubview(rightView)
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
