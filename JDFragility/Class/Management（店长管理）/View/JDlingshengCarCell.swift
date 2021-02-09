//
//  JDlingshengCarCell.swift
//  JDFragility
//
//  Created by apple on 2021/2/3.
//

import UIKit

class JDlingshengCarCell: UITableViewCell {

    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var cfdEmployeeNameL: UILabel!
    
    @IBOutlet weak var shuomingL: UILabel!
    @IBOutlet weak var carLevelL: UILabel!
    @IBOutlet weak var telL: UILabel!
    @IBOutlet weak var cfdMemberNameL: UILabel!
    @IBOutlet weak var stateL: UILabel!
    var huanKeModel:JDdianWuModel? {
        didSet {
            timeL.text = huanKeModel?.dfdCreateDate;
            cfdEmployeeNameL.text =  huanKeModel?.cfdMemberName
            cfdMemberNameL.text = huanKeModel?.cfdMoTel
            telL.text = huanKeModel?.cfdEmployeeName
            carLevelL.text = "无字段"
            stateL.text = huanKeModel?.cfdCheckState
            shuomingL.text = "无字段"

        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
