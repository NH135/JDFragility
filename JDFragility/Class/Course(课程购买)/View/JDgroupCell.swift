//
//  JDgroupCell.swift
//  JDFragility
//
//  Created by nh on 2021/1/3.
//

import UIKit

class JDgroupCell: UITableViewCell {
     
    var friendData:JDGroupDetaileModel? {
        didSet {
            self.textLabel?.text = friendData!.cfdCourseClass!

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}




// 自定义section的headerView
// 协议，点击headerView的回调
protocol HeaderViewDelegate:NSObjectProtocol {
    func headerViewDidClickedNameView(model:JDGroupModel,isSted:Bool)
}

class HeaderView: UITableViewHeaderFooterView {
    weak var delegate:HeaderViewDelegate?
 
    var letL:UILabel? =  {
        let letL:UILabel = UILabel()
        letL.font = UIFont.boldSystemFont(ofSize: 16)
        letL.textColor = UIColor.black
        return letL
    }()
 
    var nameView:UIButton? = {
        
        let nameView = UIButton.init(type: .custom)
        nameView.contentHorizontalAlignment = .right
        nameView.setImage(UIImage(named: "down"), for: .normal)
        nameView.setTitleColor(UIColor.black, for: .normal)
        nameView.setTitleColor(UIColor.k_colorWith(hexStr: "#409EFF"), for: .selected)
        return nameView
    }()
 
       var group:JDGroupModel? {
           didSet {
            if group?.cfdCourseClass?.isEmpty == false {
                letL?.text = group?.cfdCourseClass
            }else{
                letL?.text = "\(group?.cfdCIGName ?? "暂无") (\(group?.ItemList.count ?? 0) 选\(group?.ifdSelectNumber ?? "0"))"
            }
          
            if self.group?.isOpen == true {
                letL?.textColor = UIColor.k_colorWith(hexStr: "#409EFF")
   //            self.nameView?.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat( M_PI_2))
                self.nameView?.setImage(UIImage(named: "up"), for: .normal)
                self.nameView?.isSelected = true;
            }else {
   //            self.nameView?.imageView?.transform = CGAffineTransform(rotationAngle: 0)
                letL?.textColor = UIColor.black
                self.nameView?.isSelected = false;
                self.nameView?.setImage(UIImage(named: "down"), for: .normal)
            }
           }
       }
 
       
       // 返回一个headerView
       class func headerViewWithTableView(tableView:UITableView) -> HeaderView {
           let headerID = "savemyHeader"
        var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID)
           if header == nil {
               header = HeaderView.init(reuseIdentifier: headerID)
           }
           return header as! HeaderView
       }

       override init(reuseIdentifier: String?) {
           super.init(reuseIdentifier: reuseIdentifier)
           
        self.nameView!.addTarget(self, action: #selector(HeaderView.nameClick), for: .touchUpInside)
        self.contentView.addSubview(letL!)
           self.contentView.addSubview(nameView!)
           
      
           
           
       }
    @objc func nameClick() {
         
         // 刷新表格
        if ((self.delegate?.responds(to: Selector(("headerViewDidClickedNameView:")))) != nil) {
            self.delegate?.headerViewDidClickedNameView(model: self.group!,isSted:!self.nameView!.isSelected)
         }
     }
 
     override func layoutSubviews() {
         super.layoutSubviews()
         
        self.nameView?.frame = CGRect(x: 0, y: 0, width: self.width-10, height: self.frame.size.height)
        self.letL?.frame = CGRect(x: 10, y: 0, width: 150, height: self.frame.size.height)
     }
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

 }
