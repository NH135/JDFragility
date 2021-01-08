//
//  JDAttendanceController.swift
//  JDFragility
//
//  Created by apple on 2020/12/30.
//考勤排班

import UIKit

class JDAttendanceController: JDBaseViewController {

    var isNet:Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.blue
        if isNet == true {
            print("考勤排班网络请求啦")
        }
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
