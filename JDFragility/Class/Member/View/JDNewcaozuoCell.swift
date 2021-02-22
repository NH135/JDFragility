//
//  JDNewcaozuoCell.swift
//  JDFragility
//
//  Created by apple on 2021/2/22.
//

import UIKit

class JDNewcaozuoCell: UITableViewCell {

    @IBOutlet weak var fendianNameL: UILabel!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var className: UILabel!
    @IBOutlet weak var nameL: UILabel!
    
 
    
    @IBOutlet weak var yuangongL: UILabel!
    @IBOutlet weak var caozuoL: UILabel!
  
    
    var lastModel : TimeListModel?{
        didSet{
 
            timeL.text = lastModel?.dfdTimeUseDate
            className.text = lastModel?.cfdCourseName ?? "暂无"
            nameL.text = lastModel?.cfdItemName ?? "暂无"
            fendianNameL.text = lastModel?.cfdFendianName ?? "暂无"
            caozuoL.text = lastModel?.ifdOpretCount ?? "0"
            yuangongL.text = lastModel?.cfdEmployeeName ?? "0"
            
          
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
