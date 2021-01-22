//
//  JDreveredOrderCell.swift
//  JDFragility
//
//  Created by nh on 2021/1/20.
//

import UIKit

protocol reveredOrderDelegate:NSObjectProtocol {
    func reveredOrderModel(mode:JDauthoizationDetailListModel,btn1:UIButton,btn2:UIButton,btn3:UIButton,strArr:[String])
    
    
}
class JDreveredOrderCell: UITableViewCell {
    weak var delegate : reveredOrderDelegate?
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var cfdEmployeeIdABtn: UIButton!
    @IBOutlet weak var cfdEmployeeIdBBtn: UIButton!
    @IBOutlet weak var cfdEmployeeIdCBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
 
        cfdEmployeeIdABtn.k_setCornerRadius(6)
        cfdEmployeeIdABtn.k_setBorder(color: cfdEmployeeIdABtn.tintColor, width: 1)
        cfdEmployeeIdBBtn.k_setCornerRadius(6)
        cfdEmployeeIdCBtn.k_setCornerRadius(6)
        cfdEmployeeIdBBtn.k_setBorder(color: cfdEmployeeIdABtn.tintColor, width: 1)
        cfdEmployeeIdCBtn.k_setBorder(color: cfdEmployeeIdABtn.tintColor, width: 1)
 
        cfdEmployeeIdABtn.addAction { (btn) in
            let a = self.cfdEmployeeIdABtn.titleLabel?.text ?? ""
            let b = self.cfdEmployeeIdBBtn.titleLabel?.text ?? ""
            let c = self.cfdEmployeeIdCBtn.titleLabel?.text ?? ""
            if ((self.delegate?.responds(to: Selector(("reveredOrderModel")))) != nil) {
                self.delegate?.reveredOrderModel(mode: self.authoizatioOrederModel!, btn1:self.cfdEmployeeIdBBtn, btn2:self.cfdEmployeeIdCBtn, btn3:btn ,strArr:[a,b,c])
             }
        }
        cfdEmployeeIdBBtn.addAction { (btn) in
            let a = self.cfdEmployeeIdABtn.titleLabel?.text ?? ""
            let b = self.cfdEmployeeIdBBtn.titleLabel?.text ?? ""
            let c = self.cfdEmployeeIdCBtn.titleLabel?.text ?? ""
            if ((self.delegate?.responds(to: Selector(("reveredOrderModel")))) != nil) {
                self.delegate?.reveredOrderModel(mode: self.authoizatioOrederModel!, btn1:self.cfdEmployeeIdBBtn, btn2:self.cfdEmployeeIdCBtn, btn3:btn ,strArr:[a,b,c])
             }
        }
        cfdEmployeeIdCBtn.addAction { (btn) in
            let a = self.cfdEmployeeIdABtn.titleLabel?.text ?? ""
            let b = self.cfdEmployeeIdBBtn.titleLabel?.text ?? ""
            let c = self.cfdEmployeeIdCBtn.titleLabel?.text ?? ""
            if ((self.delegate?.responds(to: Selector(("reveredOrderModel")))) != nil) {
                self.delegate?.reveredOrderModel(mode: self.authoizatioOrederModel!, btn1:self.cfdEmployeeIdBBtn, btn2:self.cfdEmployeeIdCBtn, btn3:btn ,strArr:[a,b,c])
             }
        }
        
    }
    var authoizatioOrederModel : JDauthoizationDetailListModel?{
        didSet{
            nameL.text = authoizatioOrederModel?.cfdItemName
            cfdEmployeeIdABtn.setTitle(authoizatioOrederModel?.cfdEmployeeNameA ?? "暂无", for: .normal)
            cfdEmployeeIdBBtn.setTitle(authoizatioOrederModel?.cfdEmployeeNameB ?? "暂无", for: .normal)
            cfdEmployeeIdCBtn.setTitle(authoizatioOrederModel?.cfdEmployeeNameC ?? "暂无", for: .normal)
//            if authoizatiodetailnModel?.ifdReserveItemStatus == 1{
//
//                sendBtn.backgroundColor=UIColor.k_colorWith(hexStr: "409EFF")
//                sendBtn.setTitleColor(UIColor.white, for: .normal)
//            }else{
//
//                      sendBtn.backgroundColor=UIColor.k_colorWith(hexStr: "999999")
//                      sendBtn.setTitleColor(UIColor.k_colorWith(hexStr: "EEEEEE"), for: .normal)
//            }
        }
    }
 
}
