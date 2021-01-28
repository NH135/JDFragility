//
//  JDCourseshopingCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/13.
//

import UIKit


protocol shopingcourseAddDelegate:NSObjectProtocol {
    func shopingaddjianCourse(type:Bool, model:JDGroupModel)
 
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
    @IBOutlet weak var setedBtn: UIButton!
    
    var number:Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addV.k_setCornerRadius(17)
        addV.k_setBorder(color: UIColor.k_colorWith(hexStr: "429DFF"), width: 1)
        addBtn.addAction { (_) in
             
            self.number += 1
            self.numberL.text = String(self.number)
            self.baocunModelT?.ifdSumNumber = self.number;
            if ((self.delegate?.responds(to: Selector(("shopingaddjianCourse:")))) != nil) {
                self.delegate?.shopingaddjianCourse(type: true, model: self.baocunModelT!)
             }
        }
      
        jianBtn.addAction { (_) in
            if self.number == 0 {
                NHMBProgressHud.showErrorMessage(message: "不能再减了")
                return
            }
            self.number -= 1
            self.numberL.text = String(self.number)
            self.baocunModelT?.ifdSumNumber = self.number;
            if ((self.delegate?.responds(to: Selector(("shopingaddjianCourse:")))) != nil) {
                self.delegate?.shopingaddjianCourse(type: false, model: self.baocunModelT!)
             }
        }
 
        
    }
    var detaileModel:JDGroupProjectModel? {
        didSet {
            setedBtn.isHidden = true;
            nameL.text = detaileModel?.cfdCourseName
            detaileL.text = "¥\(detaileModel?.ffdPrice ?? "暂无报价")"
            numberL.text = "0"
        }
    }
    var jiesuanModel:MCListModel? {
        didSet {
            setedBtn.isHidden = true;
            nameL.text = jiesuanModel?.cfdCourseName
            detaileL.text = "¥\(jiesuanModel?.ffdNowPrice ?? "暂无报价")"
            numberL.text = "0"
        }
    }
    
//    多选保存
    var baocunModel:saveDetailModel? {
        didSet {
            nameL.text = baocunModel?.cfdItemName
//            detaileL.text = "¥\(jiesuanModel?.ffdNowPrice ?? "暂无报价")"
            detaileL.text =  baocunModel?.ifdTimes
            setedBtn.isSelected = baocunModel?.isseleted ?? false
            setedBtn.isHidden = false;
            addV.isHidden = true
        }
    }
    
    
    
    var baocunModelT:JDGroupModel? {
        didSet {
        nameL.text = baocunModelT?.cfdCourseName
 
            detaileL.text = "¥ \(baocunModelT?.ffdPrice ?? 0.0)"
            
            addV.isHidden = false
            setedBtn.isHidden = true;
        }
    }
    
    
    var ifdType:Int?{
        didSet {
            if ifdType == 1 {
            
            }else{
        
            }
        }
    }

}
