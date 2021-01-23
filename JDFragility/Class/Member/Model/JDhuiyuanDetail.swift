//
//  JDhuiyuanDetail.swift
//  JDFragility
//
//  Created by apple on 2021/1/23.
//

import UIKit
import KakaJSON

struct JDhuiyuanDetail: Convertible {
    var cfdBusListGUID:String?
    var cfdFendianId:String?;
    var cfdMemberId:String?
    var TimeList = [TimeListModel]()
    var CaiWuList = [CaiWuListModel]()
    var cfdEmployeeId:String?
    var dfdDateTime:String?;
    var ffdBusMoney:Float?;
    var ffdArrear:Float?
    var ifdState:String?;
    var cfdOpertCode:String?;
    var ifdType:String?;
    var cfdFendianName:String?;
    
    /// 展开以后的高度
    var kechengHeight: CGFloat? {
        return 137 +  CGFloat(TimeList.count) * 30.0
    }
    
    
}

struct TimeListModel: Convertible {
    var cfdCourseName:String?
    var cfdItemName:String?;
    var ifdLastNumber:String?;
    var cfdMemberTimeId:String?
    var cfdItemId:String?;
    var ifdAllNumber:String?;
    var ifdYnumber:String?;
    
    var ffdUnitPrice:String?;
    var cfdMemberId:String?
    var cfdBusListGUID:String?;
    var cfdMemberCardGUID:String?;
    var ifdType:String?;
}

struct CaiWuListModel: Convertible {
    var cfdPayMode:String?
    var ifdId:String?;
    var cfdFendianId:String?;
    var cfdEmployeeId:String?
    var dfdDateTime:String?;
    var cfdClass:String?;
    var ffdIncome:String?;
    
    var ffdPayout:String?;
    var cfdPayModeId:String?
    var cfdBusListGUID:String?;
    var cfdPayId:String?;
    var ifdBillState:String?;
}
