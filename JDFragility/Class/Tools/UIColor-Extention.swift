//
//  UIColor-Extention.swift
//  swift_demo
//
//  Created by nh on 2020/3/20.
//  Copyright © 2020 nh. All rights reserved.
//
 
import UIKit

extension UIColor{
    func asImage(size:CGSize) -> UIImage? {
        var resultImage:UIImage? = nil
        
        let rect = CGRect(x:0, y:0, width: size.width, height: size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {
            return resultImage
        }

        context.setFillColor(self.cgColor)
        context.fill(rect)
        resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resultImage
    }
}

extension UIColor {
    convenience init(r:CGFloat,g:CGFloat,b:CGFloat) {
        self.init(red: r/255.0 ,green: g/255.0 ,blue: b/255.0 ,alpha:1.0)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
}
