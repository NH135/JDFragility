//
//  JDDetaileYhjCell.swift
//  JDFragility
//
//  Created by apple on 2021/3/3.
//

import UIKit
import Kingfisher
class JDDetaileYhjCell: UITableViewCell {

    @IBOutlet weak var iconI: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var mianL: UILabel!
    @IBOutlet weak var stateTimeL: UILabel!
    @IBOutlet weak var guizeBtn: UIButton!
    @IBOutlet weak var endTimeL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        guizeBtn.addAction { (_) in
//            if self.yhjModel?.cfdRemark?.isEmpty == false {
        
            let guizeV = JDYHJAlearView.sg_loadFromNib() as? JDYHJAlearView
            guizeV?.tag = 10010
            guizeV?.guizeL.text = self.yhjModel?.cfdRemark ?? "暂无"
            guizeV?.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight)
//            guizeV.gui
            Kwindow.window?.addSubview(guizeV ?? JDYHJAlearView())
  
                
//            }
           
            
        }
        // Initialization code
    }
    var yhjModel : JDhuiyuanDetail?{
        didSet{
 
//            timeL.text = lastModel?.dfdTimeUseDate
//            className.text = lastModel?.cfdCourseName ?? "暂无"
//            nameL.text = lastModel?.cfdItemName ?? "暂无"
//            fendianNameL.text = lastModel?.cfdFendianName ?? "暂无"
//            caozuoL.text = lastModel?.ifdOpretCount ?? "0"
//            yuangongL.text = lastModel?.cfdEmployeeName ?? "0"
            
            iconI.kf.setImage(with: URL(string: yhjModel?.cfdPhoto ?? ""), placeholder: UIImage(named: "WechatIMG2222"), options: nil, progressBlock: nil, completionHandler: nil)
            nameL.text = yhjModel?.cfdTokenType
            mianL.text = "面值：\(yhjModel?.dfdFaceValue ?? "")"
            stateTimeL.text = "开始时间：\(yhjModel?.dfdCreateDate ?? "")"
            endTimeL.text = "结束时间：\(yhjModel?.dfdUseEndDatetime ?? "")"
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
