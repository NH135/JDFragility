//
//  JDkechengDetaileCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/23.
//

import UIKit

class JDkechengDetaileCell: UITableViewCell {

    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var lastContL: UILabel!
    @IBOutlet weak var moenyL: UILabel!
    @IBOutlet weak var caozuoL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()

        
    }
    var kcmodel : TimeListModel?{
        didSet{
            nameL.text = "课程：\(kcmodel?.cfdCourseName ?? "暂无")"
            lastContL.text = "购买数：\(kcmodel?.ifdAllNumber ?? "0")"
            moenyL.text = "价格：\(kcmodel?.ffdUnitPrice ?? "0")"
            caozuoL.text = "操作次数：\(kcmodel?.ifdYnumber ?? "0")"
            nameL.wl_changeFont(withTextFont:UIFont.systemFont(ofSize: 12) , changeText: "课程：")
            lastContL.wl_changeColor(withTextColor: UIColor.k_colorWith(hexStr: "999999"), changeText: "购买数：")
            moenyL.wl_changeColor(withTextColor: UIColor.k_colorWith(hexStr: "999999"), changeText: "价格：")
            caozuoL.wl_changeColor(withTextColor: UIColor.k_colorWith(hexStr: "999999"), changeText: "操作次数：")
        }
 
    }
    
}
