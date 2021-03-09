//
//  JDYHJAlearView.swift
//  JDFragility
//
//  Created by apple on 2021/3/3.
//

import UIKit

class JDYHJAlearView: UIView {

    @IBOutlet weak var guizeL: UILabel!
    @IBOutlet weak var closeB: UIButton!
    @IBOutlet weak var closeB1: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        closeB.addAction { (_) in
            Kwindow.window?.viewWithTag(10010)?.removeFromSuperview()
        }
        closeB1.addAction { (_) in
            Kwindow.window?.viewWithTag(10010)?.removeFromSuperview()
        }
    }
}
