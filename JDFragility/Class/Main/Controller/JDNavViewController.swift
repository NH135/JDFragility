//
//  JDNavViewController.swift
//  JDFragility
//
//  Created by apple on 2020/12/30.
//

import UIKit

class JDNavViewController:UINavigationController,UINavigationControllerDelegate {
    var popDelegate:UIGestureRecognizerDelegate?
     override func viewDidLoad() {
         super.viewDidLoad()
         
         //navigationBar字体颜色设置
        self.navigationBar.barTintColor = UIColor.k_colorWith(hexStr: "429DFF")
         //navigationBar字体颜色设置
         self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
         
         self.popDelegate = self.interactivePopGestureRecognizer?.delegate
         self.delegate = self
     }
     //MARK: - UIGestureRecognizerDelegate代理
        func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
            
            //实现滑动返回的功能
            //清空滑动返回手势的代理就可以实现
            if viewController == self.viewControllers[0] {
                
                self.interactivePopGestureRecognizer?.delegate = self.popDelegate
                
            } else {
                
                self.interactivePopGestureRecognizer?.delegate = nil;
            }
        }
        
     override func pushViewController(_ viewController: UIViewController, animated: Bool) {
         if viewControllers.count>0 {
             viewController.hidesBottomBarWhenPushed=true

 //            //添加图片
                        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "left")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(leftClick))
 //                       //添加文字
 //                       viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", style: .plain, target: self, action: #selector(leftClick))
     
             
             
         }
         super.pushViewController(viewController, animated: animated)
     }
     override func popViewController(animated: Bool) -> UIViewController? {
         if viewControllers.count == 0 {
             tabBarController?.tabBar.isHidden=false
         }
         return super.popViewController(animated: animated)
     }
     
     
     
     //返回上一层控制器
     @objc func leftClick()  {
 
         popViewController(animated: true)
 
     }
     
 }






