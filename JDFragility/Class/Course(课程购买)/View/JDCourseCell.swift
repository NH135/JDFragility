//
//  JDCourseCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/7.
//

import UIKit


protocol courseAddDelegate:NSObjectProtocol {
    func addjianCourse(type:Bool, model:JDGroupProjectModel)
}

class JDCourseCell: UITableViewCell {
    weak var delegate:courseAddDelegate?
    @IBOutlet weak var addV: UIView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var IconImageV: UIImageView!
    @IBOutlet weak var priceL: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var numberL: UILabel!
    @IBOutlet weak var jianBtn: UIButton!
    var number:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addV.k_setCornerRadius(17)
        addV.k_setBorder(color: UIColor.k_colorWith(hexStr: "429DFF"), width: 1)
        addBtn.addAction { (_) in
             
            self.number += 1
            self.numberL.text = String(self.number)
            if ((self.delegate?.responds(to: Selector(("addjianCourse:")))) != nil) {
                self.delegate?.addjianCourse(type: true, model: self.detaileModel!)
             }
         
        }
      
        jianBtn.addAction { (_) in
            if self.number == 0 {
                NHMBProgressHud.showErrorMessage(message: "不能再减了")
                return
            }
            
            self.number -= 1
            self.numberL.text = String(self.number)
            if ((self.delegate?.responds(to: Selector(("addjianCourse:")))) != nil) {
                self.delegate?.addjianCourse(type: false, model: self.detaileModel!)
             }
        }
        
    }
    
    
    var detaileModel:JDGroupProjectModel? {
        didSet {
            self.number = 0
            IconImageV.setCategorymageUrl(url: detaileModel?.cfdImgSrc ?? "")
            nameL.text = detaileModel?.cfdCourseName
            priceL.text = "¥\(detaileModel?.ffdPrice ?? "暂无报价")"
            numberL.text = "0"
        }
    }
}

