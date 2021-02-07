//
//  JDaddCarController.swift
//  JDFragility
//
//  Created by apple on 2021/2/4.
//

import UIKit

class JDaddCarController: JDBaseViewController , DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{

    @IBOutlet weak var telF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var seatedCarBtn: UIButton!
    @IBOutlet weak var allMoenyL: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sureBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        sureBtn.addAction { (_) in
            NetManager.ShareInstance
        }
    }


 
}
extension JDaddCarController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        UIImage(named: "zanwu")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.k_dequeueReusableCell(cls: JDlingshengCarCell.self, indexPath: indexPath)
        cell.backgroundColor = UIColor.lightText
        return cell
        
    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        40
//    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//      let xibView = Bundle.main.loadNibNamed("JDlingshengSecView", owner: nil, options: nil)?.first as! UIView
//        xibView.backgroundColor = UIColor.white
//        xibView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 40)
//      return xibView
//
//    }
//
}
