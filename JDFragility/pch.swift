//
//  nhViewController.swift
//  swift_demo
//
//  Created by nh on 2020/3/17.
//  Copyright © 2020 nh. All rights reserved.
//

import UIKit


let kScreenHeight = UIScreen.main.bounds.height
let kScreenWidth = UIScreen.main.bounds.width
let iSiPhoneX = (kScreenHeight == 812.0 ) || (kScreenHeight == 896.0)
let Kwindow = UIApplication.shared.delegate as! AppDelegate


/*底部安全区域*/
let kSafeAreaBottomHeight:CGFloat  = (iSiPhoneX ? 34 : 0)
let kSafeAreaTopHeight:CGFloat = (iSiPhoneX ? 88 : 64)
let kSystemVersion = (UIDevice.current.systemVersion as NSString).floatValue

let kMainScreenScale = UIScreen.main.scale
/*电池栏高度*/
let kStatusBarHeight = UIApplication.shared.statusBarFrame.height
/*导航总高度*/
let kNabBarHeight = (CGFloat(kStatusBarHeight) + 44.0)
let kUserDefaults = UserDefaults.standard
let kNotife = NotificationCenter.default
let kAppVersion = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
let kUUID =  UIDevice.current.identifierForVendor?.uuidString.replacingOccurrences(of: "-", with: "")
let placeholderImage = UIImage(named: "dingdanICon")


let kLineHeight = 0.5
 
/*TabBar高度*/
let  kTabBarHeight = CGFloat((iSiPhoneX ? (49.0 + 34.0):(49.0)))
 
 let PORTRAIT_AD_PLACEMENTID = "5021405801436811";
 let PORTRAIT_APPID = "1110359068";
 let PORTRAIT_AD_KAIPINGEMENTID = "8011300891530840";

// 打印内容，并包含类名和打印所在行数
func DLog<T>(_ message : T,file : String = #file,function:String = #function, lineNumber : Int = #line) {
    #if DEBUG
    let fileName = (file as NSString).lastPathComponent
    let functionStr = function.split(separator: "(").first
    print("\n**************自定义日志输出：\(fileName):\(functionStr ?? "")():[\(lineNumber)]************** \n\(message) \n**************************************************")
    #endif
}

func kImage(name:String) -> UIImage?{
    return UIImage(named: name)
}

func kFont(size:CGFloat) -> UIFont{
    return UIFont.systemFont(ofSize: size)
}
   
func kRGBCOLOR(r:CGFloat,g:CGFloat,b:CGFloat) -> UIColor{
   return UIColor(red:  r/255.0, green: g/255.0, blue:  b/255.0, alpha: 1)
}

func kRGBACOLOR(r:CGFloat,g:CGFloat,b:CGFloat, a:CGFloat) -> UIColor{
    return UIColor(red:  r/255.0, green: g/255.0, blue:  b/255.0, alpha: a)
}

//RGB 16进制转换
func KRGBHEXCOLOR(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}


