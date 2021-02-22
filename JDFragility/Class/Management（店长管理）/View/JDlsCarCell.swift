//
//  JDlsCarCell.swift
//  JDFragility
//
//  Created by apple on 2021/2/18.
//

import UIKit

class JDlsCarCell: UITableViewCell {

    @IBOutlet weak var isSeted: UIButton!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var moenyL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    var shengModel:JDlingshengModel? {
        didSet {
            nameL.text = shengModel?.cfdCourseName ?? "暂无"
            isSeted.isSelected = shengModel?.isSeted ?? false
            moenyL.text = "¥\(shengModel?.ifdCumulativeMoney != nil ? shengModel?.ifdCumulativeMoney ?? 0 : shengModel?.ffdCardApplyMoney ?? 0)"

        }
    }
    
}
