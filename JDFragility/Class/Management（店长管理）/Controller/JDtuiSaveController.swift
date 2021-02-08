//
//  JDtuiSaveController.swift
//  JDFragility
//
//  Created by apple on 2021/2/8.
//

import UIKit

class JDtuiSaveController: JDBaseViewController , DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{

    @IBOutlet weak var tel: UIButton!
    @IBOutlet weak var telF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var yuanyinF: UITextView!
    @IBOutlet weak var moneyF: UITextField!
    @IBOutlet weak var typeBtn: UIButton!
    @IBOutlet weak var sureBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "退课"
        
        typeBtn.k_cornerRadius = 15;
        typeBtn.k_setBorder(color: UIColor.k_colorWith(hexStr: "e3e3e3"), width: 1)
        typeBtn.hw_locationAdjust(buttonMode: .Right, spacing: 10)
        yuanyinF.k_cornerRadius = 4;
        yuanyinF.k_setBorder(color: UIColor.k_colorWith(hexStr: "e3e3e3"), width: 1)
        yuanyinF.k_placeholder = "请输入退款原因"
        yuanyinF.k_placeholderColor = UIColor.lightGray;
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        tableView.k_registerCell(cls: JDtuisaveCell.self)
    }

 
}
extension JDtuiSaveController:UITableViewDataSource,UITableViewDelegate{
   func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
       UIImage(named: "zanwu")
   }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.k_dequeueReusableCell(cls: JDtuisaveCell.self, indexPath: indexPath)
        cell.backgroundColor = UIColor.lightText
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      
      let xibView = Bundle.main.loadNibNamed("JDtuiSaveHeaderView", owner: nil, options: nil)?.first as! UIView
        xibView.backgroundColor = UIColor.k_colorWith(hexStr: "e9e9e9")
        xibView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 40)
      return xibView
        
    }
    
}
