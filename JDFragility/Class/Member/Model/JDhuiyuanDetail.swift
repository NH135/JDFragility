//
//  JDhuiyuanDetail.swift
//  JDFragility
//
//  Created by apple on 2021/1/23.
//

import UIKit
import KakaJSON

class JDhuiyuanDetail: Convertible {
    var cfdBusListGUID:String?
    var cfdFendianId:String?;
    var cfdMemberId:String?
    var TimeList = [TimeListModel]()
    var CardList = [TimeListModel]()
    var CaiWuList = [CaiWuListModel]()
    var cfdEmployeeId:String?
    var dfdDateTime:String?;
    var ffdBusMoney:Int?;
    var ffdIncome:Int?;
    
    var ffdArrear:Int?
    var ifdState:String?;
    var cfdOpertCode:String?;
    var ifdType:String?;
    var cfdFendianName:String?;
    var cfdPhoto:String?;
    var ifdJump :Bool?
    
    var isUse:Bool?   // 是否可使用
    var CouponUse :Int?  //状态0未使用，1已使用，2已过期
    var cfdTokenId :String?
    var isSeted :Bool?
    
    
    var cfdTokenType:String?;
    var dfdCreateDate:String?;
    var dfdUseEndDatetime:String?;
    var dfdFaceValue:String?;
    var cfdSImgSrc:String?;
    var cfdRemark:String?;
    var cfdTokenCode :String?;
    
    /// 展开以后的高度
    var kechengHeight: CGFloat? {
        return 137 +  CGFloat(TimeList.count) * 30.0
    }
    var goumaiHeight: CGFloat? {
        return 137 +  CGFloat(CardList.count) * 30.0
    }
    required init() {}
    
}

class TimeListModel: Convertible {
    var dfdTimeUseDate:String?
    var cfdCourseName:String?
    var ffdOriPrice :String?
    var ffdNowPrice :String?
    var ifdNumber :String?
   var dfdUseStartDate :String?
    var cfdItemName:String?;
    var ifdRetreatTime:String?;
    var cfdMemberTimeId:String?
    var cfdItemId:String?;
    var ifdAllNumber:String?;
    var ifdYnumber:String?;
    var ifdOpretCount:String?;
    
    var ifdChangeTime:String?
    var ifdFreezeNumber:String?
    var cfdFendianName:String?
    var cfdEmployeeName:String?
    var ifdLastNumber:String?
    var ffdUnitPrice:String?;
    var cfdMemberId:String?
    var cfdBusListGUID:String?;
    var cfdMemberCardGUID:String?;
    var ifdType:String?;
    required init() {}
}

class CaiWuListModel: Convertible {
    var cfdPayMode:String?
    var ifdId:String?;
    var cfdFendianId:String?;
    var cfdEmployeeId:String?
    var dfdDateTime:String?;
    var cfdClass:String?;
    var ffdIncome:String?;
    var cfdImgSrc:String?;
    
    var ffdPayout:String?;
    var cfdPayModeId:String?
    var cfdBusListGUID:String?;
    var cfdPayId:String?;
    var ifdBillState:String?;
    required init() {}
}
