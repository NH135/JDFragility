//
//  AppDelegate.swift
//  JDFragility
//
//  Created by apple on 2020/12/28.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         
        setWindow()
 
        return true
    }
   private func setWindow() {
//        sleep(2) //可以延长启动图显示时间，只能选择整数吗？？
       let window = UIWindow(frame: UIScreen.main.bounds)
        let userDefault = UserDefaults.standard
        let stringValue = userDefault.string(forKey: "cfdRealName")
        if (stringValue != nil) {
            window.rootViewController=JDNavViewController(rootViewController: JDMainController())
        }else{
            window.rootViewController=JDLoginController()
        }
               self.window = window
               window.makeKeyAndVisible()
    }
    
    func showWindowOutLogin() {
        //删除所有
        //获取应用域的所有字符串
        guard let appDomainString = Bundle.main.bundleIdentifier else { return  }
        UserDefaults.standard.removePersistentDomain(forName: appDomainString)
        self.window?.rootViewController=JDLoginController()
    }
    
    
    func 存数据() {
//        https://www.jianshu.com/p/0a12968bcde2
        let userDefault = UserDefaults.standard

        //Any
        userDefault.set("hangge.com", forKey: "Object")
        let objectValue:Any? = userDefault.object(forKey: "Object")

        //String类型
        userDefault.set("hangge.com", forKey: "String")
        let stringValue = userDefault.string(forKey: "String")
    
        //Array类型
        var array:Array = ["123","456"]
        userDefault.set(array, forKey: "Array")
        array = userDefault.array(forKey: "Array") as! [String]

        //Dictionary类型
        var dictionary = ["1":"hangge.com"]
        userDefault.set(dictionary, forKey: "Dictionary")
        dictionary = userDefault.dictionary(forKey: "Dictionary") as! [String : String]
        
        
        
//        读取
        var readInt = UserDefaults.standard.integer(forKey: "defaultKey")
        print(readInt)
        
        UserDefaults.standard.removeObject(forKey: "defaultKey")
        //删除所有
        //获取应用域的所有字符串
        guard let appDomainString = Bundle.main.bundleIdentifier else { return  }
        UserDefaults.standard.removePersistentDomain(forName: appDomainString)
    }

}

