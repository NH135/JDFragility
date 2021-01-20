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
    var dfdTime_End :String?
    var cfdReserveId :String?
    var cfdMemberId :String?
    var DetailList = [JDauthoizationDetailListModel]()
}
struct JDauthoizationDetailListModel: Convertible {
    var cfdMemberName :String?
    var cfdEmployeeId : String?
    var dfdTime_End :String?
    var cfdReserveId :String?
}
