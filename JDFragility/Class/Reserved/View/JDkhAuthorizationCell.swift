//
//  JDkhAuthorizationCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/20.
//

import UIKit

protocol khAuthorizatioDelegate:NSObjectProtocol {
    func khAuthorizatio(mode:JDauthoizationDetailListModel,passwordL:UILabel)
    
    
}

class JDkhAuthorizationCell: UITableViewCell {
    
    weak var delegate : khAuthorizatioDelegate?
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var passwordL: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sendBtn.cornerRadius(radius: 10)
        
        sendBtn.addAction { [self] (_) in
            if ((self.delegate?.responds(to: Selector(("khAuthorizatio")))) != nil) {
                self.delegate?.khAuthorizatio(mode: self.authoizatiodetailnModel!, passwordL: self.passwordL)
            }
        }
    }
    
    var authoizatiodetailnModel : JDauthoizationDetailListModel?{
        didSet{
            nameL.text = authoizatiodetailnModel?.cfdItemName
            if authoizatiodetailnModel?.ispassword == 0 {
                sendBtn.isHidden = true
            }else{
                sendBtn.isHidden = false
         
                if authoizatiodetailnModel?.cfdPassword == nil{
                    //                    获取
                    sendBtn.backgroundColor=UIColor.k_colorWith(hexStr: "409EFF")
                    sendBtn.setTitleColor(UIColor.white, for: .normal)
                    sendBtn.setTitle("获取", for: .normal)
                    passwordL.text = authoizatiodetailnModel?.cfdPassword ?? ""
                }else{
                    passwordL.text = ""
                    sendBtn.setTitle("未获取", for: .normal)
                    //                    未获取
                    sendBtn.backgroundColor=UIColor.k_colorWith(hexStr: "999999")
                    sendBtn.setTitleColor(UIColor.k_colorWith(hexStr: "EEEEEE"), for: .normal)
                  
                }
                
            }
            
            
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
