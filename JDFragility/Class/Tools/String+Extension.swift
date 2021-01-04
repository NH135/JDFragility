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
    
    
    /// 字符串格式化所有参数 [key: value]
    var k_paramaters: [String: String] {
        var dic: [String: String] = [:]
        let urlComponents = URLComponents.init(string: self)
        for obj in urlComponents?.queryItems ?? [] {
            dic[obj.name] = obj.value ?? ""
        }
        return dic
    }
    
    
    /// 手机号保护, 前三位展示,后四位 *(不足为 * )
    var securePhoneStr: String {
        if self.k_isEmpty {
            return self
        }
        
        let headerStr = self.k_subText(to: 2)
        var moddleStr = "****"
        var footerStr: String!
        if self.count > 7 {
            footerStr = self.k_subText(from: 7, to: self.count - 1)
        } else {
            footerStr = ""
            moddleStr = ""
            for _ in 0..<(self.count - 3) {
                moddleStr += "*"
            }
        }
        return headerStr + moddleStr + footerStr
    }
    /// 获取Nib文件路径
    var nibPath: String? {
        return Bundle.main.path(forResource: self, ofType: "nib")
    }
    /// 创建Nib文件
    var nib: UINib? {
        return UINib.init(nibName: self, bundle: nil)
    }
    /// 是否为空, 全空格/empty
    ///
    /// - Returns: 是否
    var k_isEmpty: Bool {
        if self.isEmpty {
            return true
        }
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).isEmpty
    }
    //MARK: 裁剪字符串
    /// 裁剪字符串
    ///
    /// - Parameters:
    ///   - from: 开始位置 从0开始
    ///   - to: 结束位置 包含这个位置
    ///   var str: String = "0123456789"
    ///   str = str[1, 9]
    ///   输出: str = "123456789"
    /// - Returns: 新字符串
    func k_subText(from: Int = 0, to: Int) -> String {
        if from > to { return self }
        
        let startIndex = self.startIndex
        let fromIndex = self.index(startIndex, offsetBy: max(min(from, self.count - 1), 0))
        let toIndex = self.index(startIndex, offsetBy: min(max(0, to), self.count - 1))
        
        return String(self[fromIndex ... toIndex])
    }
    //MARK: 裁剪字符串, 使用: str[0, 10]
    /// 裁剪字符串, 使用: str[0, 10]
    ///
    /// - Parameters:
    ///   - from: 开始位置 从0开始
    ///   - to: 结束位置 包含这个位置
    subscript(_ from: Int, _ to: Int) -> String {
        
        return self.k_subText(from: from, to: to)
    }
    //MARK: 替换指定区域的文字
    /// 替换指定区域的文字
    ///
    /// - Parameters:
    ///   - range: 需要替换的文字范围
    ///   - replaceStr: 替换的文字
    /// - Returns: 新字符串
    func k_replaceStr(range: NSRange, replaceStr: String) -> String {
        var newStr: String = self
        if let range = Range.init(range, in: self) {
            
            newStr.replaceSubrange(range, with: replaceStr)
            
        } else {
            
            debugPrint("范围不正确")
        }
        return newStr
    }

    
    /// 转为URL
    ///
    /// - Returns: URL
    func k_toURL() -> URL? {
        
        return URL(string: self)
    }
    //MARK: 转为Int
    /// 转为Int
    ///
    /// - Returns: Int
    func k_toInt() -> Int? {
        
        return Int(self)
    }
    //MARK: 转为转为CGFloat
    /// 转为CGFloat
    ///
    /// - Returns: CGFloat
    func k_toCGFloat() -> CGFloat {
        
        return CGFloat(Double(self) ?? 0.0)
    }
    
    
    /// 是否是数字
    var k_isNumber: Bool {
        return self.k_isRegularCorrect("^[0-9]+$")
    }
    
    /// 是否是字母
    var k_isLetter: Bool {
        return self.k_isRegularCorrect("^[A-Za-z]+$")
    }
    
    /// 正则是否匹配-谓词方式
    ///
    /// - Parameter str: str
    /// - Returns: 是否
    func k_isRegularCorrect(_ str: String) -> Bool {
        
        return NSPredicate(format: "SELF MATCHES %@", str).evaluate(with: self)
    }
    //MARK: 字符串转为日期
    /// 字符串转为日期
    ///
    /// - Parameters:
    ///   - dateStr: 字符串日期
    ///   - formatter: 字符串对应的日期格式
    ///   eg: dateStr: 2018 0908 11:20:23
    ///       formatter: yyyy MMdd HH:mm:ss
    /// - Returns: date
    func k_toDate(formatter: String) -> Date {
        let fat = DateFormatter()
        fat.dateFormat = formatter
        var date = fat.date(from: self) ?? Date()
        // 时区处理
        let timeZone = NSTimeZone.system.secondsFromGMT(for: date)
        date.addTimeInterval(TimeInterval(timeZone))
        return date
    }
    
    //MARK: 时间戳转为字符串
    /// 时间戳转为字符串
    ///
    /// - Parameters:
    ///   - timeStamp: 时间戳 10位/13位
    ///   - output: 输出格式 默认:yyyy年MM月dd日 HH:mm:ss
    /// - Returns: 日期字符串
    static func k_timeStampToDateString(_ timeStamp: String, output: String = "yyyy年MM月dd日 HH:mm:ss") -> String {
        let newTimeStamp = timeStamp.count > 10 ? (timeStamp.k_subText(to: 9)): (timeStamp)
        let str = NSString(string: newTimeStamp)
        let doubleValue = str.doubleValue
        
        let fat = DateFormatter()
        fat.dateFormat = output
        
        return fat.string(from: Date(timeIntervalSince1970: doubleValue))
    }
    //MARK: 比较两个格式相同的时间大小
    /// 比较两个格式相同的时间大小
    ///
    /// - Parameter otherTime: 时间
    /// - Returns: 结果 0: 相等; 1: otherTime大; 2: otherTime小
    func k_compareToStr(_ otherTime: String, formatter: String) -> Int {
        let resultDic: [ComparisonResult: Int] = [.orderedSame: 0, .orderedAscending: 1, .orderedDescending: 2]
        let t1 = self.k_toDate(formatter: formatter)
        let t2 = otherTime.k_toDate(formatter: formatter)
        
        return resultDic[t1.compare(t2)]!
    }
    
}

// MARK: -Json串转对象
public extension String {
    
    /// json串转为任意类型
    ///
    /// - Returns: 任意类型
    func k_jsonStrToObject() -> Any? {
        
        if self.k_isEmpty {
            return nil
        }
        if let data = self.data(using: String.Encoding.utf8) {
            return try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
        }
        return nil
    }
}


// MARK: -对象转Json串
public extension Collection {
    
    /// 转为Json字符串
    ///
    /// - Returns: json串
    func k_toJsonStr() -> String? {
        
        if let data = try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted) {
            return String.init(data: data, encoding: String.Encoding.utf8)
        }
        return nil
    }
}

// MARK: -剔除特殊字符
public extension String {
    
    /// 去除空格等 给html传值
    ///
    /// - Returns: 新字符串
    func k_noWhiteSpaceString() -> String {
        var newStr = self
        newStr = newStr.replacingOccurrences(of: "\r", with: "")
        newStr = newStr.replacingOccurrences(of: "\n", with: "")
        newStr = newStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        newStr = newStr.replacingOccurrences(of: " ", with: "")
        
        return newStr
    }
    
    /// 去除换行符等 给html传值
    ///
    /// - Returns: 新字符串
    func k_removeEnterString() -> String {
        var newStr = self
        newStr = newStr.replacingOccurrences(of: "\n", with: "<br/>")
        newStr = newStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        return newStr
    }
    
    /// 获取拼音
    ///
    /// - Returns: 拼音
    func k_toPinYin() -> String{
        let mutableString = NSMutableString(string: self)
        //把汉字转为拼音
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        //去掉拼音的音标
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        //去掉空格
        return String(mutableString).replacingOccurrences(of: " ", with: "")
    }
}
// MARK: -文字尺寸相关
public extension String {
    
    /// 计算文字宽度
    ///
    /// - Parameters:
    ///   - height: 高度
    ///   - font: 字体
    /// - Returns: 宽度
    func k_boundingWidth(height: CGFloat, font: UIFont) -> CGFloat {
        let label = UILabel()
        label.frame = CGRect(x: 0.0, y: 0.0, width: CGFloat(Int.max), height: height)
        label.font = font
        label.text = self
        label.sizeToFit()
        
        return label.frame.width
    }
    
    //MARK: 计算文字尺寸
    /// 计算文字尺寸
    ///
    /// - Parameters:
    ///   - size: 包含一个最大的值 CGSize(width: max, height: 20.0)
    ///   - font: 字体大小
    /// - Returns: 尺寸
    func k_boundingSize(size: CGSize, font: UIFont) -> CGSize {
        return NSString(string: self).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSAttributedString.Key.font : font], context: nil).size
    }
}
// MARK: -二维码相关
extension String{
    
    /// 生成二维码
    ///
    /// - Parameters:
    ///   - centerImg: 中间的小图
    ///   - block: 回调
    public func k_createQRCode(centerImg: UIImage? = nil) -> UIImage? {
        
        if self.k_isEmpty {
            return nil
        }
        let filter = CIFilter.init(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        filter?.setValue(self.data(using: String.Encoding.utf8, allowLossyConversion: true), forKey: "inputMessage")
        if let image = filter?.outputImage {
            let size: CGFloat = 300.0
            
            let integral: CGRect = image.extent.integral
            let proportion: CGFloat = min(size/integral.width, size/integral.height)
            
            let width = integral.width * proportion
            let height = integral.height * proportion
            let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
            let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
            
            let context = CIContext(options: nil)
            if let bitmapImage: CGImage = context.createCGImage(image, from: integral) {
                bitmapRef.interpolationQuality = CGInterpolationQuality.none
                bitmapRef.scaleBy(x: proportion, y: proportion);
                bitmapRef.draw(bitmapImage, in: integral);
                if let image: CGImage = bitmapRef.makeImage() {
                    var qrCodeImage = UIImage(cgImage: image)
                    if let centerImg = centerImg {
                        // 图片拼接
                        UIGraphicsBeginImageContextWithOptions(qrCodeImage.size, false, UIScreen.main.scale)
                        qrCodeImage.draw(in: CGRect(x: 0.0, y: 0.0, width: qrCodeImage.size.width, height: qrCodeImage.size.height))
                        centerImg.draw(in: CGRect(x: (qrCodeImage.size.width - 35.0) / 2.0, y: (qrCodeImage.size.height - 35.0) / 2.0, width: 35.0, height: 35.0))
                        
                        qrCodeImage = UIGraphicsGetImageFromCurrentImageContext() ?? qrCodeImage
                        UIGraphicsEndImageContext()
                        return qrCodeImage
                    } else {
                        return qrCodeImage
                    }
                } else {
                    return nil
                }
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    //MARK: - 生成高清的UIImage
    func _setUpHighDefinitionImage(_ image: CIImage, size: CGFloat) -> UIImage? {
        let integral: CGRect = image.extent.integral
        let proportion: CGFloat = min(size/integral.width, size/integral.height)
        
        let width = integral.width * proportion
        let height = integral.height * proportion
        let colorSpace: CGColorSpace = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: 0)!
        
        let context = CIContext(options: nil)
        let bitmapImage: CGImage = context.createCGImage(image, from: integral)!
        
        bitmapRef.interpolationQuality = CGInterpolationQuality.none
        bitmapRef.scaleBy(x: proportion, y: proportion);
        bitmapRef.draw(bitmapImage, in: integral);
        if let image: CGImage = bitmapRef.makeImage() {
            return UIImage(cgImage: image)
        }
        return nil
    }
}
// MARK: -编解码
public extension String {
    
    /// 编码之后的url
    var k_urlEncoded: String? {
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    
    /// 解码之后的url
    var k_urlDecoded: String? {
        return removingPercentEncoding
    }
    
    /// base64编码之后的字符串
    var k_base64Encoded: String? {
        guard let base64Data = data(using: .utf8) else { return nil }
        return base64Data.base64EncodedString()
    }
    
    /// base64解码之后的字符串
    var k_base64Decoded: String? {
        guard let base64Data = Data(base64Encoded: self) else { return nil }
        return String(data: base64Data, encoding: .utf8)
    }
    
}


// MARK: -数据转模型
public extension String {
    
    /*
    // 使用方法
    class TestModel: Decodable {
        let text: String?
    }
    "{\"text\": \"zcc\"}".k_convertToModel(modelType: TestModel.self)
    */
    /// Json转Model模型工具
    /// 数据模型的属性必须跟接口返回的数据类型相匹配!!!
    /// - Parameter modelType: T.Type
    /// - Returns: 数据模型
    func k_convertToModel <T: Decodable>(modelType: T.Type) -> T? {
        guard let jsonData = self.data(using: String.Encoding.utf8) else { return nil }
        
        return try? JSONDecoder().decode(modelType, from: jsonData)
    }
}
// MARK: -数据转模型
public extension Data {
    
    /// JsonData转Model模型工具
    /// 数据模型的属性必须跟接口返回的数据类型相匹配!!!
    ///
    /// - Parameter modelType: NSObject.self
    /// - Returns: 数据模型
    func k_convertToModel <T: Decodable>(modelType: T.Type) -> T? {
        return try? JSONDecoder().decode(modelType, from: self)
    }
}
