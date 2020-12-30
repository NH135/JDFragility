//
//  UIButton+HWExtension.swift
//  Swift-UIButton位置扩展
//
//  Created by Hanwen on 2018/7/2.
//  Copyright © 2018年 东莞市三心网络科技有限公司. All rights reserved.
//

import Foundation
import UIKit


let cmButtonAssociatedkey = UnsafeRawPointer.init(bitPattern: "cmButtonAssociatedkey".hashValue)
enum HWButtonMode {
    case Top
    case Bottom
    case Left
    case Right
}


extension UIButton {

    /// 快速调整图片与文字位置
    ///
    /// - Parameters:
    ///   - buttonMode: 图片所在位置
    ///   - spacing: 文字和图片之间的间距
    func hw_locationAdjust(buttonMode: HWButtonMode,
                                             spacing: CGFloat) {
        let imageSize = self.imageRect(forContentRect: self.frame)
        let titleFont = self.titleLabel?.font!
        let titleSize = titleLabel?.text?.size(withAttributes: [kCTFontAttributeName as NSAttributedString.Key: titleFont!]) ?? CGSize.zero
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        switch (buttonMode){
        case .Top:
            titleInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing)/2,
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing)/2, left: 0, bottom: 0, right: -titleSize.width)
        case .Bottom:
            titleInsets = UIEdgeInsets(top: -(imageSize.height + titleSize.height + spacing)/2,
                                       left: -(imageSize.width), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: (imageSize.height + titleSize.height + spacing)/2, left: 0, bottom: 0, right: -titleSize.width)
        case .Left:
            titleInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -spacing)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        case .Right:
            titleInsets = UIEdgeInsets(top: 0, left: -(imageSize.width * 2), bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0,
                                       right: -(titleSize.width * 2 + spacing))
        }
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
    
    
    
    
    func addAction(for controlEvents: UIControl.Event,action:@escaping (UIButton)->()) {
        objc_setAssociatedObject(self, cmButtonAssociatedkey!, action, .OBJC_ASSOCIATION_COPY_NONATOMIC)
          self.addTarget(self, action: #selector(cmButtonClick), for: controlEvents)
      }
      
      func addAction(_ action:@escaping (UIButton)->()) {
        objc_setAssociatedObject(self, cmButtonAssociatedkey!, action, .OBJC_ASSOCIATION_COPY_NONATOMIC)
          self.addTarget(self, action: #selector(cmButtonClick), for: .touchUpInside)
      }
      
    @objc func cmButtonClick() {
          if let action = objc_getAssociatedObject(self, cmButtonAssociatedkey!) as? (UIButton)->() {
              action(self)
          }
      }
    
}
