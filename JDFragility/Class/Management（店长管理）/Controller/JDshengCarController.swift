//
//  JDshengCarController.swift
//  JDFragility
//
//  Created by apple on 2021/2/3.
//

import UIKit

class JDshengCarController: JDBaseViewController , DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    @IBOutlet weak var starTimeBtn: UIButton!
    @IBOutlet weak var endTimeBtn: UIButton!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var textF: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "升卡"
        starTimeBtn.k_cornerRadius = 4
        endTimeBtn.k_cornerRadius = 4
        endTimeBtn.k_setBorder(color: UIColor.k_colorWith(hexStr: "EAEAEA"), width: 1)
        starTimeBtn.k_setBorder(color: UIColor.k_colorWith(hexStr: "EAEAEA"), width: 1)
        searchBtn.cornerRadius(radius: 4)
        sureBtn.cornerRadius(radius: 4)
    tableView.emptyDataSetSource = self
    tableView.emptyDataSetDelegate = self
         tableView.delegate = self
         tableView.dataSource = self
         tableView.k_registerCell(cls: JDlingshengCarCell.self)
     }
  
 }
 extension JDshengCarController:UITableViewDataSource,UITableViewDelegate{
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        UIImage(named: "zanwu")
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         20
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.k_dequeueReusableCell(cls: JDlingshengCarCell.self, indexPath: indexPath)
         cell.backgroundColor = UIColor.lightText
         return cell
         
     }
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         40
     }
     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
       let xibView = Bundle.main.loadNibNamed("JDlingshengSecView", owner: nil, options: nil)?.first as! UIView
         xibView.backgroundColor = UIColor.lightText
         xibView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 40)
       return xibView
         
     }
     
 }
