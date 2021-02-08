//
//  JDtuisaveCell.swift
//  JDFragility
//
//  Created by apple on 2021/2/8.
//

import UIKit

protocol tuiKeAddDelegate:NSObjectProtocol {
    func tuikejianCourse(type:Bool, model:JDGroupProjectModel)
}

class JDtuisaveCell: UITableViewCell {
    weak var delegate:tuiKeAddDelegate?
    @IBOutlet weak var addV: UIView!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var jianBtn: UIButton!
    @IBOutlet weak var numberL: UILabel!
    
    
    
    var number = 0 
    override func awakeFromNib() {
        super.awakeFromNib()
        addV.k_setCornerRadius(17)
        addV.k_setBorder(color: UIColor.k_colorWith(hexStr: "429DFF"), width: 1)
        addBtn.addAction { (_) in
             
            self.number += 1
            self.numberL.text = String(self.number)
            if ((self.delegate?.responds(to: Selector(("tuikejianCourse:")))) != nil) {
                self.delegate?.tuikejianCourse(type: true, model: JDGroupProjectModel())
             }
         
        }
      
        jianBtn.addAction { (_) in
            if self.number == 0 {
                NHMBProgressHud.showErrorMessage(message: "不能再减了")
                return
            }
            
            self.number -= 1
            self.numberL.text = String(self.number)
            if ((self.delegate?.responds(to: Selector(("tuikejianCourse:")))) != nil) {
                self.delegate?.tuikejianCourse(type: false, model: JDGroupProjectModel())
             }
        }
        
    }
 
    
}
