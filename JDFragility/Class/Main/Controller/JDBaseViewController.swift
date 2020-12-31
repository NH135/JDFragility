 //
//  JDBaseViewController.swift
//  JDFragility
//
//  Created by apple on 2020/12/28.
//

import UIKit

class JDBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.white
        edgesForExtendedLayout = .bottom
    }
    

    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
            if title == "首页" {
                navigationController?.navigationBar.isHidden=true
            }
      }
      override func viewDidDisappear(_ animated: Bool) {
          super.viewDidDisappear(animated)
//             if title == "首页" {
//                      navigationController?.navigationBar.isHidden=false
//                  }
      }


}
