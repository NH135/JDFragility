//
//  JDCourseshopingCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/13.
//

import UIKit


protocol shopingcourseAddDelegate:NSObjectProtocol {
 
    func shopingaddjianCourse(type:Bool, model:JDGroupModel)
    func huanaddjianCourse(type:Bool, model:JDGroupProjectModel)
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
          
            if self.baocunModelT?.cfdCourseName?.isEmpty == false {
                self.number += 1
                self.numberL.text = String(self.number)
                self.baocunModelT?.ifdSumNumber = self.number;
                if ((self.delegate?.responds(to: Selector(("shopingaddjianCourse:")))) != nil) {
                    self.delegate?.shopingaddjianCourse(type: true, model: self.baocunModelT!)
                 }
            }else if self.huanModel?.cfdCourseName?.isEmpty == false{
                if self.number == self.huanModel?.ifdAllNumber{
                    NHMBProgressHud.showErrorMessage(message: "不能再加了")
                    return
                }
                self.number += 1
                self.numberL.text = String(self.number)
                self.huanModel?.ifdSumNumber = self.number;
                if ((self.delegate?.responds(to: Selector(("huanaddjianCourse:")))) != nil) {
                    self.delegate?.huanaddjianCourse(type: true, model: self.huanModel!)
                 }
            }
            
           
        }
      
        jianBtn.addAction { (_) in
            if self.number == 0 {
                NHMBProgressHud.showErrorMessage(message: "不能再减了")
                return
            }
            
            if self.baocunModelT?.cfdCourseName?.isEmpty == false {
            self.number -= 1
            self.numberL.text = String(self.number)
            self.baocunModelT?.ifdSumNumber = self.number;
            if ((self.delegate?.responds(to: Selector(("shopingaddjianCourse:")))) != nil) {
                self.delegate?.shopingaddjianCourse(type: false, model: self.baocunModelT!)
             }
            }else if self.huanModel?.cfdCourseName?.isEmpty == false{
                self.number -= 1
                self.numberL.text = String(self.number)
                self.huanModel?.ifdSumNumber = self.number;
                if ((self.delegate?.responds(to: Selector(("huanaddjianCourse:")))) != nil) {
                    self.delegate?.huanaddjianCourse(type: true, model: self.huanModel!)
                 }
            }
        }
 
        
    }
    var detaileModel:JDGroupProjectModel? {
        didSet {
            iconV.setCategorymageUrl(url: detaileModel?.cfdImgSrc ?? "")
            setedBtn.isHidden = true;
            nameL.text = detaileModel?.cfdCourseName
            detaileL.text = "¥\(detaileModel?.ffdPrice ?? "暂无报价")"
            numberL.text = "0"
        }
    }
    var huanModel:JDGroupProjectModel? {
        didSet {
            iconV.setCategorymageUrl(url: huanModel?.cfdImgSrc ?? "")
            setedBtn.isHidden = true;
            nameL.text = huanModel?.cfdCourseName
            detaileL.text = "  \(huanModel?.ifdAllNumber ?? 0)  "
            detaileL.cornerRadius(radius: detaileL.height/2)
            detaileL.backgroundColor = UIColor.red
            detaileL.textColor = UIColor.white
            numberL.text = "\(huanModel?.ifdSumNumber ?? 0)"
            addV.isHidden = false
        }
    }
    
   
    
    var jiesuanModel:MCListModel? {
        didSet {
            iconV.setCategorymageUrl(url: jiesuanModel?.cfdImgSrc ?? "")
            setedBtn.isHidden = true;
            nameL.text = jiesuanModel?.cfdCourseName
            detaileL.text = "¥\(jiesuanModel?.ffdNowPrice ?? "暂无报价")"
            numberL.text = "0"
        }
    }
    
//    多选保存
    var baocunModel:saveDetailModel? {
        didSet {
            iconV.setCategorymageUrl(url: baocunModel?.cfdImgSrc ?? "")
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
            iconV.setCategorymageUrl(url: baocunModelT?.cfdImgSrc ?? "")
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
