//
//  JDjiesuanModel.swift
//  JDFragility
//
//  Created by apple on 2021/1/14.
//

import UIKit
import KakaJSON
//BusList = {
//    cfdBusListGUID = d7f9402f-f176-47c9-94d2-a5d9be9c0563;
//    cfdEmployeeId = 146ad23c-7d78-4152-be45-c626ccbd36cd;
//    dfdDateTime = 2021-01-14 15:45:36;
//    cfdBusMoney = 35000;
//    ffdArrear = 0;
//    ifdType = <null>;
//    cfdOpertCode = 5287469501635357762;
//    cfdMemberId = 9cb24ed5-ac6d-44b2-9760-143812c21292;
//    ifdState = 0;
//    cfdRemark = <null>;
//    cfdFendianId = 29b7d770-08a5-43d5-a1e6-c664543f8422
//};
//CodeMsg = {
//    cfdBusListGUID = d7f9402f-f176-47c9-94d2-a5d9be9c0563;
//    dfdCreateDate = 2021-01-14 15:45:36;
//    ifdType = 1;
//    cfdReserveId = <null>;
//    cfdCodeUrl = <null>;
//    cfdCodeMsgId = 4735322112677527658;
//    cfdCodeMsgName = ItemCode;
//    ifdConfirm = 0
//}
struct JDjiesuanModel: Convertible {
    var BusList = BusListModel()
    var CodeMsg = CodeMsgModel()
    var MCList = [MCListModel]()
}
struct BusListModel: Convertible {
    var ffdBusMoney : String?
    
//    cfdBusListGUID = d7f9402f-f176-47c9-94d2-a5d9be9c0563;
//    cfdEmployeeId = 146ad23c-7d78-4152-be45-c626ccbd36cd;
//    dfdDateTime = 2021-01-14 15:45:36;
//    cfdBusMoney = 35000;
//    ffdArrear = 0;
//    ifdType = <null>;
//    cfdOpertCode = 5287469501635357762;
//    cfdMemberId = 9cb24ed5-ac6d-44b2-9760-143812c21292;
//    ifdState = 0;
//    cfdRemark = <null>;
//    cfdFendianId = 29b7d770-08a5-43d5-a1e6-c664543f8422
}
struct MCListModel: Convertible {
    var ffdNowPrice : String?
    var cfdCourseName : String?
    //    cfdCreateUser = 罗俊杰;
    //    ifdTerm = 1;
    //    cfdCourseName = CYS全身溶脂;
    //    ifdType = 0;
    //    ffdOriPrice = 1000;
    //    ffdNowPrice = 1000;
    //    cfdRemark = <null>;
    //    dfdDeadline = 2021-01-14 15:45:36;
    //    cfdBusListGUID = d7f9402f-f176-47c9-94d2-a5d9be9c0563;
    //    cfdMemberCardGUID = fe23a961-8494-4370-842f-3f570da99489;
    //    ifdNumber = 1;
    //    cfdMemberId = 9cb24ed5-ac6d-44b2-9760-143812c21292;
    //    dfdLastModiDate = 2021-01-14 15:45:36;
    //    ifdState = 1;
    //    ifdSort = 5;
    //    dfdCreateDate = 2021-01-14 15:45:36;
    //    cfdCourseId = e9d6c32e-5964-4041-aa1f-079b6284d856;
    //    cfdLastModiUser = 罗俊杰
}
struct CodeMsgModel: Convertible {
    var cfdCodeMsgId : String?
//    cfdBusListGUID = d7f9402f-f176-47c9-94d2-a5d9be9c0563;
//    dfdCreateDate = 2021-01-14 15:45:36;
//    ifdType = 1;
//    cfdReserveId = <null>;
//    cfdCodeUrl = <null>;
//    cfdCodeMsgId = 4735322112677527658;
//    cfdCodeMsgName = ItemCode;
//    ifdConfirm = 0
}
struct payModel: Convertible {
    var cfdPayMode : String?
    var cfdPayModeId : String?
    var ffdIncome : String?
    var ifdId : Int?
//    cfdBusListGUID = d7f9402f-f176-47c9-94d2-a5d9be9c0563;
//    dfdCreateDate = 2021-01-14 15:45:36;
//    ifdType = 1;
//    cfdReserveId = <null>;
//    cfdCodeUrl = <null>;
//    cfdCodeMsgId = 4735322112677527658;
//    cfdCodeMsgName = ItemCode;
//    ifdConfirm = 0
}
