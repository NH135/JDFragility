//
//  JDshenglingCell.swift
//  JDFragility
//
//  Created by apple on 2021/2/18.
//

import UIKit

class JDshenglingCell: UITableViewCell {

    @IBOutlet weak var mendianNameL: UILabel!
    @IBOutlet weak var isSeted: UIButton!
    @IBOutlet weak var moneyTypeL: UILabel!
    @IBOutlet weak var moneyL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
 
    var gouModel:JDlingshengModel? {
        didSet {
            mendianNameL.text = gouModel?.cfdFendianName ?? "暂无"
            isSeted.isSelected = gouModel?.isSeted ?? false
            moneyTypeL.text = gouModel?.cfdPayMode
            moneyL.text = "¥\(gouModel?.ffdIncome ?? 0)"
            timeL.text = gouModel?.dfdCheckTime
            

        }
    }
}
