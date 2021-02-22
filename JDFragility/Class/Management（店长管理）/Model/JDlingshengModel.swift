//
//  JDlingshengModel.swift
//  JDFragility
//
//  Created by apple on 2021/2/18.
//

import UIKit
import KakaJSON

class JDlingshengModel: Convertible {

//    cfdEmployeeId = 146ad23c-7d78-4152-be45-c626ccbd36cd;
//    cfdMoTel = <null>;
//    BusDateTime = <null>;
//    cfdBillState = <null>;
//    cfdCheckEmployeeId = 146ad23c-7d78-4152-be45-c626ccbd36cd;
//    ffdPayout = 0;
//    ifdType = 1;
//    cfdPayMode = 微信;
//    cfdMemberName = <null>;
//    dfdDateTime = 2021-01-28 17:52:27;
//    cfdOpertCode = 5675407339580600613;
//    cfdEmployeeName = <null>;
//    cfdFendianNameE = <null>;
//    cfdPayModeId = 5c19bfaf-f2a0-488c-bea7-30a26ea3ba85;
//    cfdClass = 1;
//    cfdBusListGUID = 3409d520-5e35-4cf2-aaf0-ad9484aa5d70;
//    ffdIncome = 0;
//    cfdPayId = <null>;
//    ifdBillState = 1;
//    dfdCheckTime = 2021-02-01 11:36:52;
//    cfdFendianId = 0dcb5023-eac3-45a8-96fa-28c441c8bb9a;
//    cfdStoreAssistantRole = <null>;
//    ifdId = 749235aa-7434-49af-a3bc-11ce505f6873;
//    cfdRemark = <null>
    
    var isSeted:Bool = false
    var cfdPayMode : String?
    var dfdDateTime : String?
    var dfdCheckTime : String?
    var cfdFendianName : String?
    var ffdIncome : Int?
    var cfdBusListGUID : String?
 
    var ifdBillState: String?
    var cfdPayId: String?
    var ifdId: String?
    var ffdAvailableMoney : Int?
    
    
//    ifdCumulativeMonth = 6;
//    dfdCreateDate = 0001-01-01 00:00:00;
//    cfdCreateUser = <null>;
//    dfdLastModiDate = 0001-01-01 00:00:00;
//    cfdLastModiUser = <null>;
//    ItemList = (
//    );
//    ifdGrade = 2;
//    cfdCourseId = eeb5bfc8-536e-4b9a-b5bb-012337937da9;
//    cfdCourseName = 尊宠卡2021;
//    ifdCumulativeMoney = 100000
    var ffdCardApplyMoney: Int?
    var ffdNowPrice : Int?
    var ifdCumulativeMoney : Int?
    var cfdCourseName : String?
    var cfdCourseId : String?
    var ifdCumulativeMonth : String?
    var ifdGrade : String?
    var cfdCardApplyGUID : String?
    
    required init() {}
}
