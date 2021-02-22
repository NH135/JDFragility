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
    
    
    
    @IBOutlet weak var lastCountL: UILabel!
    @IBOutlet weak var goumaiCountL: UILabel!
    @IBOutlet weak var xiangmuNameL: UILabel!
    @IBOutlet weak var priceL: UILabel!
    @IBOutlet weak var kechengNameL: UILabel!
    var number = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        addV.k_setCornerRadius(17)
        addV.k_setBorder(color: UIColor.k_colorWith(hexStr: "429DFF"), width: 1)
        addBtn.addAction { (_) in
            guard self.number <  (self.tuiModel?.ifdAllNumber)! else{
                NHMBProgressHud.showErrorMessage(message: "不能再加了")
                return
            }
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
 
    var tuiModel:JDGroupProjectModel? {
        didSet {
            kechengNameL.text = tuiModel?.cfdCourseName
            priceL.text = "\(tuiModel?.ffdUnitPrice ?? 0)";
            xiangmuNameL.text = tuiModel?.cfdItemName
            goumaiCountL.text = "\(tuiModel?.ifdAllNumber ?? 0)"
            lastCountL.text = tuiModel?.ifdLastNumber
//            setedBtn.isHidden = true;
//            nameL.text = huanModel?.cfdCourseName
//            detaileL.text = "  \(huanModel?.ifdAllNumber ?? 0)  "
//            detaileL.cornerRadius(radius: detaileL.height/2)
//            detaileL.backgroundColor = UIColor.red
//            detaileL.textColor = UIColor.white
            
            
            
//            numberL.text = "\(huanModel?.ifdSumNumber ?? 0)"
//            addV.isHidden = false
        }
    }
}
