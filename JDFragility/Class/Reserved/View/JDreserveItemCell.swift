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
//        bgV.backgroundColor=UIColor.k_randomColor
        bgV.cornerRadius(radius: 20)
    }
    
    var resListModel : ResListModel? {
        didSet{

            if resListModel?.ifdState == 0{
                bgV.backgroundColor=UIColor.k_colorWith(hexStr: "19BE6B")
            }else if resListModel?.ifdState == 1{
                bgV.backgroundColor=UIColor.k_colorWith(hexStr: "8167F5")
            }else if resListModel?.ifdState == 2{
                bgV.backgroundColor=UIColor.k_colorWith(hexStr: "58A3F7")
            }else if resListModel?.ifdState == 3{
                bgV.backgroundColor=UIColor.k_colorWith(hexStr: "CCCCCC")
            }
            
            timeL.text =  "\(resListModel?.cfdTimeStar ?? "") - \(resListModel?.cfdTimeEnd ?? "")"
            nameL.text = resListModel?.cfdMemberName
        }
    }
}
