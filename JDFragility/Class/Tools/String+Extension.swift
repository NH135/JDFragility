//
//  String+Extension.swift
//  AlamofireEncapsulation
//
//  Created by Ethan.Wang on 2018/9/7.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import Foundation
import UIKit
extension String {
    var length: Int {
        ///更改成其他的影响含有emoji协议的签名
        return self.utf16.count
    }
    
    ///是否包含字符串
    func containsIgnoringCase(find: String) -> Bool {
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    /// 获取一段字符串的宽度
        ///
        /// - Parameter fontSize: 字体大小
        /// - Returns: 字符串宽度
        func width(fontSize:CGFloat) -> CGFloat {
            return self.size(withAttributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontSize)]).width
        }
    /// 截取任意位置到结束
    ///
    /// - Parameter end:
    /// - Returns: 截取后的字符串
    func stringCutToEnd(star: Int) -> String {
        if !(star < count) { return "截取超出范围" }
        let sRang = index(startIndex, offsetBy: star)..<endIndex
        return String(self[sRang])
//        return substring(with: sRang)
    }
    /// 从零开始截取到某个位置：
       /// - Parameter index: 达到某个位置
       public func substring(to index: Int) -> String {
           if(self.count > index){
               let endindex = self.index(self.startIndex, offsetBy: index)
               let subString = self[self.startIndex..<endindex]
               return String(subString)
           }else{
               return self
           }
       }
       
       /// 某个范围内截取
       /// - Parameter rangs: 范围
       public func subString(rang rangs:NSRange) -> String{
           var string = String()
           if(rangs.location >= 0) && (count > (rangs.location + rangs.length)){
               let startIndex = self.index(self.startIndex,offsetBy: rangs.location)
               let endIndex = self.index(self.startIndex,offsetBy: (rangs.location + rangs.length))
               let subString = self[startIndex..<endIndex]
               string = String(subString)
           }
           return string
       }
    static func nowTimeWithFormat(format:String) -> String {
            let dateFormatter:DateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "kDate_Location")
//            dateFormatter.locale = Locale(identifier: kDate_Location)
            return  dateFormatter.string(from: Date())
        }
}
