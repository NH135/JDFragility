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

    var lingModel:JDlingshengModel? {
        didSet {
            nameL.text = lingModel?.cfdCourseName ?? "暂无"
            isSeted.isSelected = lingModel?.isSeted ?? false
            moenyL.text = "¥\(lingModel?.ffdCardApplyMoney ?? 0)"

        }
    }
    var shengModel:JDlingshengModel? {
        didSet {
            nameL.text = shengModel?.cfdCourseName ?? "暂无"
            isSeted.isSelected = shengModel?.isSeted ?? false
            moenyL.text = "¥\( shengModel?.ifdCumulativeMoney ?? 0 )"

        }
    }
    
}
