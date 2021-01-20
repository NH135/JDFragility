//
//  JDkhAuthorizationCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/20.
//

import UIKit

protocol khAuthorizatioDelegate:NSObjectProtocol {
    func khAuthorizatio(mode:ResListModel,passwordL:UILabel)
    
    
}

class JDkhAuthorizationCell: UITableViewCell {
 
    weak var delegate : khAuthorizatioDelegate?
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var passwordL: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        sendBtn.addAction { [self] (_) in
            if ((self.delegate?.responds(to: Selector(("khAuthorizatio")))) != nil) {
                self.delegate?.khAuthorizatio(mode: ResListModel(), passwordL: self.passwordL)
             }
        }
    }

   
    
}
