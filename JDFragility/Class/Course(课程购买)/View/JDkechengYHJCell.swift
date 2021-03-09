//
//  JDkechengYHJCell.swift
//  JDFragility
//
//  Created by apple on 2021/3/7.
//

import UIKit


protocol jiezhangYhjSetedDelegate:NSObjectProtocol {
 
    func jzyhj(isEnd:Bool, model:JDhuiyuanDetail?)
    
}

class JDkechengYHJCell: UITableViewCell {
    weak var delegate:jiezhangYhjSetedDelegate?
    @IBOutlet weak var steedB: UIButton!
    @IBOutlet weak var bgV: UIView!
    @IBOutlet weak var rV: UIView!
    @IBOutlet weak var lV: UIView!
    
    @IBOutlet weak var yhjL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib() 
        bgV.k_cornerRadius = 8
        rV.k_cornerRadius = 10
        lV.k_cornerRadius = 10
        steedB.addAction { (btn) in
//            var CouponUse :Int?  //状态0未使用，1已使用，2已过期
            if  self.kcYhjModel?.isUse == true{
//                guard  self.kcYhjModel?.CouponUse != 1 || self.kcYhjModel?.CouponUse != 2 else {
//                    NHMBProgressHud.showErrorMessage(message: "当前购买课程不可使用！")
//                    return
//                }

                if  self.kcYhjModel?.CouponUse == 1 {
                    NHMBProgressHud.showErrorMessage(message: "已使用!")
                }else  if  self.kcYhjModel?.CouponUse == 1 {
                    NHMBProgressHud.showErrorMessage(message: "已过期！")
                }else{
                
            if btn.isSelected == true{
                btn.isSelected = false
                self.kcYhjModel?.isSeted = false;
            }else{
                btn.isSelected = true
                self.kcYhjModel?.isSeted = true;
            }
            
            if ((self.delegate?.responds(to: Selector(("jzyhj:")))) != nil) {
                self.delegate?.jzyhj(isEnd: btn.isSelected, model: self.kcYhjModel!)
             }
                
            }
            }else{
                NHMBProgressHud.showErrorMessage(message: "当前购买课程不可使用！")
         
            }
        }
    }
    
    var kcYhjModel:JDhuiyuanDetail? {
        didSet {
            yhjL.text = "\(kcYhjModel?.cfdTokenType ?? "") / \(kcYhjModel?.dfdFaceValue ?? "")"
            if kcYhjModel?.isUse == true{
                bgV.backgroundColor = UIColor.k_colorWith(hexStr: "#58A3F7")
            }else{
                bgV.backgroundColor = UIColor.lightGray
            }
//            var CouponUse :Int?  //状态0未使用，1已使用，2已过期
//          v
//                bgV.backgroundColor = UIColor.lightGray
//
//            }
            
        }
    }
}
