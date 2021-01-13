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
    
    var cfdLevelID:String?
    
    var ResList = [ResListModel]()
    var cfdLevel :String?
    
    var cfdSex:String?
    //cfdLevelID = 5a9a5bcb-77ff-4ef8-9aa4-f262f3b95d75;
    //ResList = (
    //);
    //cfdCardId = 310115198801022939;
    //ImageUrl = img_01.jpg;
    //cfdContacts = <null>;
    //dfdComeTime = 1900-01-01 00:00:00;
    //cfdTel = 15921882433;
    //cfdRealName = 罗俊杰;
    //dfdContract = 1900-01-01 00:00:00;
    //cfdIntroducer = <null>;
    //dfdHealthRecord = 1900-01-01 00:00:00;
    //dfdCreateDate = <null>;
    //cfdDepartmentId = 31e332bd-46c2-4546-b0fd-50d3e127c7bb;
    //IsShopShow = 1;
    //AppletOpenID = ogR0_5eCtftXR4iUo1VKP7FNPvbg;
    //cfdFendianId = 29b7d770-08a5-43d5-a1e6-c664543f8422;
    //cfdIdCardImage = <null>;
    //cfdContractNo = <null>;
    //cfdRemarks = ;
    //cfdbank = ;
    //dfdLastModiDate = <null>;
    //cfdContactsTel = <null>;
    //IsReserve = 1;
    //cfdaccount = <null>;
    //ffdBasicPay = 0;
    //dfdBirthday = 1900-01-01 00:00:00;
    //ifdState = 1;
    //cfdImage = img_01.jpg;
  
    //dfdJobDate = 1900-01-01 00:00:00;
    //cfdPhoto = img_01.jpg;
    //cfdLastModiUser = <null>;
    //cfdEmployeeId = 146ad23c-7d78-4152-be45-c626ccbd36cd;
    //cfdbankopenname = 罗俊杰;
    //cfdJobNumber = cici;
    //cfdIdCard = 310115198801022939;
    //cfdAddress = ;
    //cfdCreateUser = <null>;
    //ifdEmployeeLevel = 6;
    //isRecommend = 1
}

struct ResListModel:Convertible {
    
    var cfdMemberName:String?
    var cfdEmployeeId:String?
    
    var cfdTimeStar:String?
    var cfdCreateUser:String?
    var dfdToTime:String?
    var cfdTimeEnd:String?
    var cfdReserveId:String?
    var ifdRoomId:String?
    var cfdMemberId:String?
    var cfdFendianId:String?
    var ifdState:String?
    var dfdCreateDate:String?
   
}
