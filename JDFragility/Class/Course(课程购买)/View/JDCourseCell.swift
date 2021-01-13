//
//  JDCourseCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/7.
//

import UIKit

class JDCourseCell: UITableViewCell {

    @IBOutlet weak var addV: UIView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var IconImageV: UIImageView!
    @IBOutlet weak var priceL: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var numberL: UILabel!
    @IBOutlet weak var jianBtn: UIButton!
    var number:Int = 1
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addV.k_setCornerRadius(17)
        addV.k_setBorder(color: UIColor.k_colorWith(hexStr: "429DFF"), width: 1)
        addBtn.addAction { (_) in
            self.number += 1
            self.numberL.text = String(self.number)
        }
      
        jianBtn.addAction { (_) in
            if self.number == 0 {
                NHMBProgressHud.showErrorMessage(message: "不能再减了")
                return
            }
            
            self.number -= 1
            self.numberL.text = String(self.number)
        }
        
    }
    
    
    var detaileModel:JDGroupProjectModel? {
        didSet {
            nameL.text = detaileModel?.cfdCourseName
            priceL.text = "¥\(detaileModel?.ffdPrice ?? "暂无报价")"
            numberL.text = "0"
        }
    }
}
