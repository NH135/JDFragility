//
//  JDWebClient.swift
//  JDFragility
//
//  Created by apple on 2020/12/30.
//

import UIKit

let JDUrl_login:String = "api/IPad/IPadLogin";//登录


typealias callSuccessBlock = ([Any]) ->()
typealias callFailureBlock = (_ FailureStr :String) ->()

class JDWebClient: NSObject {
    static func userInfoRequestcompleteSuccess(callSuccessBlock: callSuccessBlock,callFailureBlock:callFailureBlock) {
         NetManager.ShareInstance.getWith(url: JDUrl_login, params: nil, success: { (respons) in
              guard let dict = respons as? [String : Any] else { return }
//              guard let arr = dict["data"] as? [String : Any] else { return }
//             let mode = BaseUsers.deserialize(from: arr)
                DLog(dict)
//               let userDefaults = UserDefaults.standard
//
//             userDefaults.set(mode?.user.loginTime, forKey: "loginTime")
  
         }) { (str) in
             DLog(str)
         }
     }
}
