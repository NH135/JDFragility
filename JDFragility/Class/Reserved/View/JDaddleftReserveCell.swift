//
//  JDaddleftReserveCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/20.
//

import UIKit
protocol leftModelDelegate:NSObjectProtocol {
    func addleftModel(mode:ResListModel)
    
    
}
class JDaddleftReserveCell: UITableViewCell {
    weak var delegate:leftModelDelegate?
    @IBOutlet weak var iconI: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var lastCount: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    var addIndex :Int = 0;
    
    var addReserve : ResListModel? {
        didSet{
            iconI.setCategorymageUrl(url: addReserve?.cfdImgSrc ?? "")
            nameL.text =  addReserve?.cfdCourseName ?? "暂无"
            lastCount.text = "\(addReserve?.ifdLastNumber ?? 0)"
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lastCount.k_setCornerRadius(10)
        addBtn.addAction { (btn:UIButton) in
        
            
            if  self.addReserve?.ifdLastNumber == 0{
                NHMBProgressHud.showErrorMessage(message: "不能再加啦～～")
                return
            }
                
            
            if ((self.delegate?.responds(to: Selector(("addleftModel")))) != nil) {
                self.delegate?.addleftModel(mode: self.addReserve!)
             }
            self.addReserve?.ifdLastNumber! -= 1
        }
    }

   
    
}
