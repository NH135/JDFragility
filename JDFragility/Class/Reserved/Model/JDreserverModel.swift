//
//  JDreserverModel.swift
//  JDFragility
//
//  Created by apple on 2021/1/6.
//

import UIKit
import KakaJSON


struct JDreserverModel: Convertible {
    
    var cfdEmployeeName:String?
    //cfdEmployeeName = 罗俊杰;
    var cfdEmployeeId : String?
    var cfdCreateUser:String?
    var cfdLevelID:String?
    
    var ResList = [ResListModel]()
    var cfdLevel :String?
    
    var cfdSex:String?
   
}

class ResListModel:Convertible {
    
    var cfdMemberName:String?
    var cfdEmployeeId:String?
    var cfdReserveDetailGUID :String?
    var cfdMoTel :String?
    var cfdTimeStar:String?
    var cfdCreateUser:String?
    var dfdToTime:String?
    var cfdTimeEnd:String?
    var cfdReserveId:String?
    var ifdRoomId:String?
    var cfdMemberId:String?
    var cfdFendianId:String?
    var ifdState:Int?
    var dfdCreateDate:String?
    var cfdImgSrc :String?
    var cfdItemName :String?
    var cfdCourseName:String?
    var cfdBusListGUID:String?
    var cfdMemberCardGUID:String?
    var ifdAllNumber:String?
    var ifdLastNumber:Int?
    var cfdItemId:String?
    var cfdMemberTimeId:String?
    required init() {}
   
}
