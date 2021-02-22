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
            nameL.text = "课程名称：\(kcmodel?.cfdCourseName ?? "暂无")"
            lastContL.text = "原价：¥\(kcmodel?.ffdOriPrice ?? "0")"
            moenyL.text = "现价：¥\(kcmodel?.ffdNowPrice ?? "0")"
            caozuoL.text = "数量：\(kcmodel?.ifdNumber ?? "0")"
            nameL.wl_changeFont(withTextFont:UIFont.systemFont(ofSize: 12) , changeText: "课程：")
            lastContL.wl_changeColor(withTextColor: UIColor.k_colorWith(hexStr: "999999"), changeText: "购买数：")
            moenyL.wl_changeColor(withTextColor: UIColor.k_colorWith(hexStr: "999999"), changeText: "价格：")
            caozuoL.wl_changeColor(withTextColor: UIColor.k_colorWith(hexStr: "999999"), changeText: "操作次数：")
        }
 
    }
    
}
