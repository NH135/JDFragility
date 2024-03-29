//
//  JDGroupProjectModel.swift
//  JDFragility
//
//  Created by apple on 2021/1/11.
//

import UIKit
import KakaJSON

class JDGroupProjectModel: Convertible {
//    ItemList = (
//    );
//    dfdSaleEndDate = 2025-01-01 00:00:00;
//    cfdCreateUser = system;
//    ifdTerm = 1;
//    cfdCourseName = CYS全身溶脂;
//    ffdPrice = 1000;
//    ifdType = 0;
//    ifdIsFormalCourse = 1;
//    ifdSelectNumber = 1;
//    ifdManyTimes = 1;
//    ifdIfUse = 1;
//    cfdCourse_Code = <null>;
//    cfdCourseClassId = 6e7f52d9-61aa-43cb-8095-1e19101d097e;
//    dfdLastModiDate = 2021-01-11 10:54:11;
//    dfdSaleStartDate = 2021-01-01 00:00:00;
//    ifdSort = 5;
//    dfdCreateDate = 2021-01-11 10:54:11;
//    cfdCourseId = e9d6c32e-5964-4041-aa1f-079b6284d856;
//    cfdLastModiUser = system
    
    var cfdCourseName:String?
//    var ItemList = []
    var cfdImgSrc:String?
    
    var ffdPrice:String?
    var dfdCreateDate:String?
    var cfdCourseClassId:String?
    var cfdCourseId:String?
    var ifdTerm:String?
    var ifdSort:String?
    var ifdRefNumber:Int?
    
    var ifdChangeNumber :Int?
    
    
    //换课ItemList
 
    var cfdItemName:String?
    var ifdChangeTime:Int?
    var ffdUnitPrice:Int?
    var ifdRetreatTime:Int?
    var ifdType:Int?
    var cfdBusListGUID :String?
    var dfdUseStartDate:String?
    var dfdUseEndDate:String?
    var cfdMemberCardGUID:String?
    var cfdMemberId:String?
    var ifdState:Int?
    var ifdAllNumber:Int?
    var cfdItemId:String?
    var cfdMemberTimeId:String?
    var ifdYnumber:String?
    var ifdLastNumber:Int?
    var ifdSumNumber:Int = 1
    required init() {}
}




struct JDsaveKCModel: Convertible {
    
    var ffdPrice:String?
    var dfdCreateDate:String?
    var cfdCourseClassId:String?
    var cfdCourseId:String?
    var ifdTerm:String?
    var ifdSort:String? 
    
    
}
