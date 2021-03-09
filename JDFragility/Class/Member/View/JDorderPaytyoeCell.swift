//
//  JDorderPaytyoeCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/23.
//

import UIKit
import Kingfisher
class JDorderPaytyoeCell: UICollectionViewCell {
    @IBOutlet weak var payTypeL: UIButton!
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var timeL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
  
    }
    var payModel : CaiWuListModel?{
        didSet{
//            payTypeL.text = "课程：\(kcmodel?.cfdCourseName ?? "暂无")"
//            lastContL.text = "购买数：\(kcmodel?.ifdAllNumber ?? "0")"
//            moenyL.text = "价格：\(kcmodel?.ffdUnitPrice ?? "0")"
//            caozuoL.text = "操作次数：\(kcmodel?.ifdYnumber ?? "0")"
            
            icon.kf.setImage(with: URL(string: payModel?.cfdImgSrc ?? ""), placeholder: placeholderImage, options: nil, progressBlock: nil, completionHandler: nil)
 
            payTypeL.setTitle(payModel?.cfdPayMode ?? "暂无", for: .normal)
            timeL.text = "¥\(payModel?.ffdIncome ?? "")"
            if payModel?.cfdPayMode == "现金" {
                payTypeL.setTitleColor(UIColor.k_colorWith(hexStr: "7ABBFF"), for: .normal)
            }else  if payModel?.cfdPayMode == "支付宝" {
                payTypeL.setTitleColor(UIColor.k_colorWith(hexStr: "7ABBFF"), for: .normal)
            }else  if payModel?.cfdPayMode == "微信" {
                payTypeL.setTitleColor(UIColor.k_colorWith(hexStr: "19BE6B"), for: .normal)
            }else{
                payTypeL.setTitleColor(UIColor.k_colorWith(hexStr: "333333"), for: .normal)
            }
        }
 
    }
}
