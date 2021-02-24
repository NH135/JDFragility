//
//  JDauthoizationModel.swift
//  JDFragility
//
//  Created by apple on 2021/1/20.
//

import UIKit
import KakaJSON

struct JDauthoizationModel: Convertible {
    var cfdMemberName :String?
    var cfdEmployeeId : String?
    
    var cfdEmployeeName : String?
    var dfdTime_End :String?
    var cfdReserveId :String?
    var cfdMemberId :String?
    var DetailList = [JDauthoizationDetailListModel]()
}
struct JDauthoizationDetailListModel: Convertible {
  
    
    var cfdItemId :String?
    var cfdEmployeeNameC : String?
    var cfdItemName :String?
    var ifdTimes :String?
    var cfdReserveDetailGUID :String?
    var cfdEmployeeNameA : String?
    var cfdEmployeeNameB :String?
    var cfdReserveId :String?
    var cfdMemberCardGUID : String?
    var ifdEquipmentId :String?
    var cfdEmployeeIdB :String?
    var cfdEmployeeIdC : String?
    var cfdEmployeeIdA :String?
    var ifdReserveItemStatus :Int?
    var ispassword :Int?
    var cfdPassword :String?
    var ifdIspassword : Bool?
    
    
}

struct JDdeleteModel: Convertible {
    var ifdKTId :String?
    var ifdKDId : String?
    
    var cfdKey : String?
    var CreateUser :String?
    var cfdValue :String?
    var cfdName :String?
}
 
