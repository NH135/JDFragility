//
//  JDwebController.swift
//  JDFragility
//
//  Created by apple on 2021/3/15.
//

import UIKit
import WebKit

class JDwebController: JDBaseViewController {
    @IBOutlet weak var wkView: WKWebView!
    var url : String?
    @IBOutlet weak var titles: UILabel!
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
        //创建网址
           let urlStr = NSURL(string: url!)
           //创建请求
        let request = NSURLRequest(url: urlStr! as URL)
           //加载请求
        wkView.load(request as URLRequest)
       
    }
    @IBAction func black(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

     
}
