//
//  JDCourseshopingCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/13.
//

import UIKit


protocol shopingcourseAddDelegate:NSObjectProtocol {
    func shopingaddjianCourse(type:Bool, model:JDGroupProjectModel)
}
class JDCourseshopingCell: UITableViewCell {
    weak var delegate:shopingcourseAddDelegate?
    @IBOutlet weak var iconV: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var detaileL: UILabel!
    @IBOutlet weak var addV: UIView!
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
            if ((self.delegate?.responds(to: Selector(("shopingaddjianCourse:")))) != nil) {
                self.delegate?.shopingaddjianCourse(type: true, model: self.detaileModel!)
             }
         
        }
      
        jianBtn.addAction { (_) in
            if self.number == 0 {
                NHMBProgressHud.showErrorMessage(message: "不能再减了")
                return
            }
            
            self.number -= 1
            self.numberL.text = String(self.number)
            if ((self.delegate?.responds(to: Selector(("shopingaddjianCourse:")))) != nil) {
                self.delegate?.shopingaddjianCourse(type: false, model: self.detaileModel!)
             }
        }
        
    }
    var detaileModel:JDGroupProjectModel? {
        didSet {
            nameL.text = detaileModel?.cfdCourseName
            detaileL.text = "¥\(detaileModel?.ffdPrice ?? "暂无报价")"
            numberL.text = "0"
        }
    }
    var jiesuanModel:MCListModel? {
        didSet {
            nameL.text = jiesuanModel?.cfdCourseName
            detaileL.text = "¥\(jiesuanModel?.ffdNowPrice ?? "暂无报价")"
            numberL.text = "0"
        }
    }
}
