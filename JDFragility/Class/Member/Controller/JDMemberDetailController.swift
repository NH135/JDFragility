//
//  JDMemberDetailController.swift
//  JDFragility
//
//  Created by apple on 2021/1/8.
//

import UIKit

class JDMemberDetailController: JDBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let erwIimage = UIImageView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        erwIimage.backgroundColor=UIColor.red
        erwIimage.k_createQrImage(url: "2131233232", placeholder: UIImage())
        view.addSubview(erwIimage)
        
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
