//
//  JDyuyueAuthorization Controller.swift
//  JDFragility
//
//  Created by apple on 2021/1/13.
//

import UIKit

class JDyuyueAuthorization_Controller: JDBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let im = UIImageView(image: UIImage(named: "kerenshou"))
        im.frame = view.bounds
        view.addSubview(im)
        
    }

    @IBAction func closeBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
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
