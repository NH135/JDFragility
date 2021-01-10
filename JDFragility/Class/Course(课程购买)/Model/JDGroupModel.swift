//
//  JDGroupModel.swift
//  JDFragility
//
//  Created by nh on 2021/1/3.
//

import UIKit
import KakaJSON

struct JDGroupModel: Convertible {

    var cfdCourseClass:String?
    var list = [JDGroupDetaileModel]()
    // 这个变量是控制分组是否打开的，如果打开则设定展示cell的个数
    var isOpen:Bool? = false
    
    var cfdCourseClassId:String?
    var dfdCreateDate:String?
    var ifdState:String?
    var ifdOrder:String?
    
}

struct JDGroupDetaileModel:Convertible {
    
    var cfdCreateUser:String?
    var cfdRemarks:String?
    var cfdImageUrl1:String?
    var cfdImageUrl2:String?
    var cfdCourseClassId:String?
    var cfdCourseClass:String?
    var dfdCreateDate:String?
    var ifdState:String?
    var ifdOrder:String?
}
