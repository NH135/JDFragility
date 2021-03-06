//
//  JDmemberModel.swift
//  JDFragility
//
//  Created by nh on 2021/1/9.
//

import UIKit
import KakaJSON

struct JDmemberModel: Convertible {
    var cfdSource:String?
    var cfdSourceId:String?;
    var cfdCreateUser:String?
    var Member = MemberDetailModel()
    
    var BadNumber:String?
    var ffdPayMoney:String?;
    var CycleNumber:String?;
    var UnitPrice:String?
    var MonthsNumber:String?;
    var cfdPhoto:String?
    
    var ffdConMoney:String?;
    var LastDataTime:String?;
}

class MemberDetailModel : Convertible {
    var cfdMemberName:String?
    var cfdEmployeeName:String?
    var cfdSource:String?
    var cfdMoTel:String?
    var dfdCreateDate:String?
    var cfdFendianName:String?
    var dfdBirthday:String?
    var cfdPhoto:String?
    var cfdAgreeMentImg:String?
    var ffdBalance:String?
    
    var cfdMemberId:String?
 
    var cfdLevelID:String?
    var cfdCardId:String?
    var ImageUrl:String?
    var cfdRealName:String?
    var cfdDepartmentId:String?
    var AppletOpenID:String?
    var cfdFendianId:String?
    var IsReserve:String?
    var cfdEmployeeId:String?
    var cfdIdCard:String?
    var ifdEmployeeLevel:String?
    var isRecommend:String?
    var isSeted:Bool = false
    required init() {}
    //    cfdMemberName = 李文龙;
//    cfdEmployeeName = <null>;
//    cfdPhone = 18627912021;
//    cfdEmail = <null>;
//    cfdFendianName = 培训部;
//    ifdConsumeSms = 1;
//    cfdMoTel = 18627912021;
//    cfdParent = <null>;
//    dfdCreateDate = <null>;
//    cfdSource = 嘉宾;
//    cfdAscFendian = 0dcb5023-eac3-45a8-96fa-28c441c8bb9a;
//    cfdWeixinOpenid = o9NOiw5uUE74kv3Mijh-SBZ4_Rzc;
//    cfdPaperId = ;
//    cfdRegFendian = 0dcb5023-eac3-45a8-96fa-28c441c8bb9a;
//    ffdIntegral = 0;
//    cfdSourceType = <null>;
//    dfdLastModiDate = <null>;
//    ifdClientType = 0;
//    ifdMarriage = 0;
//    cfdRemark = ;
//    ifdMarketingSms = 1;
//    ifdWeight = 0;
//    dfdBirthday = 1993-06-07 00:00:00;
//    ifdState = 1;
//    cfdPassWord = <null>;
//    cfdMemberName = 李文龙;
//    cfdAppletOpenId = <null>;
//    cfdSex = 1;
//    ifdOccupation = 0;
//    cfdPhoto = <null>;
//    cfdLastModiUser = <null>;
//    cfdMemberId = 9cb24ed5-ac6d-44b2-9760-143812c21292;
//    cfdRegFendianName = 培训部;
//    cfdAddress = ;
//    cfdEmployeeId = <null>;
//    cfdMemberGradeId = <null>;
//    cfdAgreeMentImg = <null>;
//    cfdSourceId = a493f84d-f20f-4215-b18e-9826a158555c;
//    cfdCreateUser = <null>;
//    ifdHeight = 0;
//    ffdBalance = 0;
//    BirthDay = <null>;
//    cfdMemberGradeName = <null>
}
