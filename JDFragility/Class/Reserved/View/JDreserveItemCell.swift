//
//  JDreserveItemCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/6.
//

import UIKit

class JDreserveItemCell: UICollectionViewCell {

    @IBOutlet weak var bgV: UIView!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var nameL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        bgV.backgroundColor=UIColor.k_randomColor
        bgV.cornerRadius(radius: 20)
    }
    
    var resListModel : ResListModel? {
        didSet{
//            + "-" + resListModel?.dfdTime_End ?? ""
            timeL.text =  "\(resListModel?.cfdTimeStar ?? "") - \(resListModel?.cfdTimeEnd ?? "")"
            nameL.text = resListModel?.cfdMemberName
        }
    }
}
