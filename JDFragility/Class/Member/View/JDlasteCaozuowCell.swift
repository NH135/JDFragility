//
//  JDlasteCaozuowCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/24.
//

import UIKit

class JDlasteCaozuowCell: UITableViewCell {

    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var goumaiL: UILabel!
    @IBOutlet weak var caozuoL: UILabel!
    @IBOutlet weak var tuihuanL: UILabel!
    @IBOutlet weak var lastL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    var lastModel : TimeListModel?{
        didSet{
//            payTypeL.text = "课程：\(kcmodel?.cfdCourseName ?? "暂无")"
//            lastContL.text = "购买数：\(kcmodel?.ifdAllNumber ?? "0")"
//            moenyL.text = "价格：\(kcmodel?.ffdUnitPrice ?? "0")"
//            caozuoL.text = "操作次数：\(kcmodel?.ifdYnumber ?? "0")"
//            ifdLastNumber = 3;    ifdYnumber = 0;    ifdAllNumber = 3
            className.text = lastModel?.cfdCourseName ?? "暂无"
            nameL.text = lastModel?.cfdItemName ?? "暂无"
            
            goumaiL.text = lastModel?.ifdAllNumber ?? "0"
            caozuoL.text = lastModel?.ifdYnumber ?? "0"
            tuihuanL.text = lastModel?.ifdRefundNumber ?? "0"
            lastL.text = lastModel?.ifdLastNumber ?? "0"
            
        }
    }
    
}
