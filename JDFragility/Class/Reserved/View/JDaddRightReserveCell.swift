//
//  JDaddRightReserveCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/20.
//

import UIKit
protocol rightModelDelegate:NSObjectProtocol {
    func addrightModel(mode:ResListModel)
    
    
}
class JDaddRightReserveCell: UITableViewCell {
    
    weak var delegate:rightModelDelegate?
    @IBOutlet weak var removeB: UIButton!
    @IBOutlet weak var nameL: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        removeB.addAction { (_) in
            if ((self.delegate?.responds(to: Selector(("addrightModel")))) != nil) {
                self.delegate?.addrightModel(mode: self.addReserve!)
             }
        }
    }

    var addReserve : ResListModel? {
        didSet{
            nameL.text =  addReserve?.cfdCourseName ?? "暂无"
        }
    }
    
    
}
