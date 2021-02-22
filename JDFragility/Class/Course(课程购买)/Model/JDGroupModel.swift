//
//  JDGroupModel.swift
//  JDFragility
//
//  Created by nh on 2021/1/3.
//

import UIKit
import KakaJSON

class JDGroupModel: Convertible {

    var cfdCourseClass:String?
    var list = [JDGroupDetaileModel]()
    // 这个变量是控制分组是否打开的，如果打开则设定展示cell的个数
    var isOpen:Bool? = false
    var cfdImgSrc : String?
    var cfdCourseClassId:String?
    var dfdCreateDate:String?
    var ifdState:String?
    var ifdOrder:String?
    var ffdOriPrice:Float?
    
    
//    保存自选套餐
    var cfdCourseName:String?
    var  cfdMemberCardGUID :String?
    var  ffdPrice :Float?
    var ifdTerm :String?
    var ifdSort :String?
    var ifdType:Int?
    var cfdCourseId:String?
    var ifdSelectNumber : String?
 
    var cfdCIGName : String?
    var cfdCourseItemGroupId : String?
    var ItemList = [saveDetailModel]()
    
    
    var ifdSumNumber : Int?
    
    
    required init() {}
}

class JDGroupDetaileModel:Convertible {
    
    var cfdCreateUser:String?
    var cfdRemarks:String?
    var cfdImageUrl1:String?
    var cfdImageUrl2:String?
    var cfdCourseClassId:String?
    var cfdCourseClass:String?
    var dfdCreateDate:String?
    var ifdState:String?
    var ifdOrder:String?
    var isSeleted:Bool = false
    
    required init() {}
}
