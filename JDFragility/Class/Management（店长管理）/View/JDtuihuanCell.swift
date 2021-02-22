//
//  JDtuihuanCell.swift
//  JDFragility
//
//  Created by apple on 2021/2/19.
//

import UIKit

class JDtuihuanCell: UITableViewCell {

    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var cfdEmployeeNameL: UILabel!
    
    @IBOutlet weak var shuomingL: UILabel!
    @IBOutlet weak var yuancarLevelL: UILabel!
    @IBOutlet weak var carLevelL: UILabel!
    @IBOutlet weak var telL: UILabel!
    @IBOutlet weak var cfdMemberNameL: UILabel!
    @IBOutlet weak var stateL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var lingshengModel:JDdianWuModel? {
        didSet {
            timeL.text =  lingshengModel?.dfdCardApplyDate;
            cfdEmployeeNameL.text =  lingshengModel?.cfdMoTel
            cfdMemberNameL.text = lingshengModel?.cfdMemberName
            telL.text = lingshengModel?.cfdEmployeeName
            yuancarLevelL.text = lingshengModel?.cfdCourseNameOld ?? "暂无"
            carLevelL.text = lingshengModel?.cfdCourseNameNew
            stateL.text = lingshengModel?.cfdStatus
            shuomingL.text = lingshengModel?.cfdApplyType ?? "暂无"

        }
    }
     
    
}
