//
//  UIBarButtonLtem-Extension.swift
//  swift_demo
//
//  Created by nh on 2020/3/20.
//  Copyright © 2020 nh. All rights reserved.
//

import Foundation
import UIKit
extension UIBarButtonItem{
    convenience init(imageName:String,highlightedImage:String = "",size :CGSize = CGSize.zero) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highlightedImage !=  "" {
               btn.setImage(UIImage(named: highlightedImage), for: .highlighted)
        }
        if size != CGSize.zero {
            btn.frame=CGRect(origin: CGPoint.zero, size: size)
        }else{
            btn.sizeToFit()
        }
      
        self.init(customView:btn)
        
    }
}
