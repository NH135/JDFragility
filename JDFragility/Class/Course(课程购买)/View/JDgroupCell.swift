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
            self.textLabel?.text = friendData!.name!

        }
    }
 
    
    //            override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    //                super.init(style: style, reuseIdentifier: reuseIdentifier)
    //
    //            }
    //
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }

    override func awakeFromNib() {
        super.awakeFromNib()
       textLabel?.text = "friendData!.name!"
    }
}




// 自定义section的headerView
// 协议，点击headerView的回调
protocol HeaderViewDelegate:NSObjectProtocol {
    func headerViewDidClickedNameView(headerView:HeaderView)
}

class HeaderView: UITableViewHeaderFooterView {
    weak var delegate:HeaderViewDelegate?
 
    var countView:UILabel? =  {
        let countView:UILabel = UILabel()
       
        countView.textColor = UIColor.gray
        return countView
    }()
 
    var nameView:UIButton? = {
        
        let nameView = UIButton.init(type: .custom)
//        nameView.setBackgroundImage(UIImage(named: "buddy_header_bg"), for: .normal)
//        nameView.setBackgroundImage(UIImage(named: "buddy_header_bg_highlighted"), for: .highlighted)s
//// 设定那个group的小角
//        nameView.setImage(UIImage(named: "buddy_header_arrow"), for: .normal)
        nameView.setTitleColor(UIColor.black, for: .normal)
        
        nameView.contentHorizontalAlignment = .left
        nameView.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        nameView.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        
        nameView.imageView?.contentMode = .center
        nameView.imageView?.clipsToBounds = false
        return nameView
    }()
 
       var group:JDGroupModel? {
           didSet {
            self.nameView?.setTitle(group!.name!, for: .normal)
           
               didMoveToSuperview()
           }
       }
       
       // 返回一个headerView
       class func headerViewWithTableView(tableView:UITableView) -> HeaderView {
           let headerID = "myHeader"
        var header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerID)
           if header == nil {
               header = HeaderView.init(reuseIdentifier: headerID)
           }
           return header as! HeaderView
       }

       override init(reuseIdentifier: String?) {
           super.init(reuseIdentifier: reuseIdentifier)
           
        self.nameView!.addTarget(self, action: #selector(HeaderView.nameClick), for: .touchUpInside)
           
           self.contentView.addSubview(nameView!)
           
           self.contentView.addSubview(countView!)
           
           
       }
    @objc func nameClick() {
         self.group?.isOpen = !self.group!.isOpen!
         // 刷新表格
        if ((self.delegate?.responds(to: Selector(("headerViewDidClickedNameView:")))) != nil) {
            self.delegate?.headerViewDidClickedNameView(headerView: self)
         }
     }
     override func didMoveToSuperview() {
         super.didMoveToSuperview()
         if self.group!.isOpen == true {
            self.nameView?.imageView?.transform = CGAffineTransform(rotationAngle: CGFloat( M_PI_2))
         }else {
            self.nameView?.imageView?.transform = CGAffineTransform(rotationAngle: 0)
         }
     }
 
     override func layoutSubviews() {
         super.layoutSubviews()
         
         self.nameView?.frame = self.bounds
        let countH:CGFloat = self.frame.size.height
         let countW:CGFloat = 150
         let countY:CGFloat = 0
         let countX:CGFloat = self.frame.size.width - 10 - countW
        self.countView?.frame = CGRect(x: countX, y: countY, width: countW, height: countH)
     }
    required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }

 }
