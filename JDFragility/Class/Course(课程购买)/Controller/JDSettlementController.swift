//
//  JDSettlementController.swift
//  JDFragility
//
//  Created by nh on 2021/1/12.
//

import UIKit

class JDSettlementController: JDBaseViewController,UITableViewDelegate,UITableViewDataSource {
 
    @IBOutlet weak var iconImagV: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var telL: UILabel!
    @IBOutlet weak var lastML: UILabel!
    @IBOutlet weak var mdL: UILabel!
    @IBOutlet weak var ewmL: UIImageView!
    @IBOutlet weak var fuML: UILabel!
    @IBOutlet weak var wanB: UIButton!
    @IBOutlet weak var yuB: UIButton!
    @IBOutlet weak var yhjB: UIButton!
    @IBOutlet weak var yhjL: UILabel!
    
    
    @IBOutlet weak var rightTableView: UITableView!
    @IBOutlet weak var shifuML: UILabel!
    @IBOutlet weak var sureB: UIButton!
    @IBOutlet weak var wxT: UITextField!
    @IBOutlet weak var ylT: UIButton!
    @IBOutlet weak var zfbT: UITextField!
    @IBOutlet weak var yeT: UIButton!
    
    @IBOutlet weak var coseB: UIButton!
    @IBOutlet weak var yhjTableView: UITableView!
    @IBOutlet weak var contenView: UIView!
    
    @IBOutlet weak var contenL: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor=UIColor.k_colorWith(hexStr: "f8f8f8")
        
        setData()
        setletfUI()
        setrightUI()
        setcontenUI()
    }

    
    
    
    
 
}

extension JDSettlementController{
    func setData()  {
       
    }
    
}

extension JDSettlementController{
    func setletfUI()  {
        wanB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.yuB.isEnabled = true
        }
        
        yuB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.wanB.isEnabled = true
        }
    }
    
}

extension JDSettlementController{
    func setrightUI()  {
       
    }
    
}


extension JDSettlementController{

    func setcontenUI()  {
        contenL.cornerRadius(corners: [.topLeft ,.topRight], radius: 10)
        contenView.backgroundColor=UIColor.black.withAlphaComponent(0.3)
        coseB.addAction { (_) in
            self.contenView.isHidden = true
        }
    }
    
}


extension JDSettlementController{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == yhjTableView {
         return 20
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == yhjTableView {
            
            
        }
        return UITableViewCell()
    }
    

}
