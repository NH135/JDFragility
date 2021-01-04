//
//  JDGroupModel.swift
//  JDFragility
//
//  Created by nh on 2021/1/3.
//

import UIKit

class JDGroupModel: BaseModel {

    var name:String?
    var friends: NSMutableArray?
    // 这个变量是控制分组是否打开的，如果打开则设定展示cell的个数
    var isOpen:Bool? = false
    
    
//    init(withDic dic:NSDictionary) {
//           super.init()
//           self.setValuesForKeysWithDictionary(dic as! [String : AnyObject])
//
//           let  arrayFriend:NSMutableArray = NSMutableArray()
//
//           for friendDic in self.friends! {
//               let friend :JDGroupDetaileModel = JDGroupDetaileModel.init(dic: friendDic as! NSDictionary)
//               arrayFriend.addObject(friend)
//           }
//
//           self.friends = arrayFriend
//
//       }
       
    
}

class JDGroupDetaileModel:BaseModel {
    
    var name:String?
    var id:String?
   
}
