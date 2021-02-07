//
//  JDlingCarController.swift
//  JDFragility
//
//  Created by apple on 2021/2/3.
//

import UIKit

class JDlingCarController: JDBaseViewController , DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{

    @IBOutlet weak var starTimeBtn: UIButton!
    @IBOutlet weak var endTimeBtn: UIButton!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var textF: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var page:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "领卡"
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
        
        starTimeBtn.addAction { (btn:UIButton) in
            self.view.endEditing(true)
            let dataPicker = DateTimePickerView()
            dataPicker.pickerViewMode = DatePickerViewDateYearMonthDay
            dataPicker.timeStr = {(date) in
                self.starTimeBtn.setTitle("  \(date ?? "  请选择开始时间")", for: .normal)
                self.starTimeBtn.setTitleColor(UIColor.black, for: .normal)
            }
            dataPicker.show()
            Kwindow.window?.addSubview(dataPicker)
        }
        
        endTimeBtn.addAction { (btn:UIButton) in
            self.view.endEditing(true)
            let dataPicker = DateTimePickerView()
            dataPicker.pickerViewMode = DatePickerViewDateYearMonthDay
            dataPicker.timeStr = {(date) in
                self.endTimeBtn.setTitle("  \(date ?? "  请选择结束时间")", for: .normal)
                self.endTimeBtn.setTitleColor(UIColor.black, for: .normal)
            }
            dataPicker.show()
            Kwindow.window?.addSubview(dataPicker)
        }
        searchBtn.addAction { (_) in
            
            
            let cfdFendianId = UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""
            let params = ["cfdFendianId":cfdFendianId,"StartDateTime":self.starTimeBtn.titleLabel?.text ?? "","EndDateTime":self.endTimeBtn.titleLabel?.text ?? "" ,"ifdApplyType":"false","page":self.page,"limit":"20","Keyword":self.textF.text!] as [String : Any]

 
            NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryCardApplyList", params: params) { (dic) in
                print(dic)
            } error: { (error) in
            
            }

        }
        sureBtn.addAction { (_) in
            let addCar = JDaddCarController()
            self.navigationController?.pushViewController(addCar, animated: true)
            
        }
        
    }
 
}
extension JDlingCarController:UITableViewDataSource,UITableViewDelegate{
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
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      
      let xibView = Bundle.main.loadNibNamed("JDlingshengSecView", owner: nil, options: nil)?.first as! UIView
        xibView.backgroundColor = UIColor.white
        xibView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 40)
      return xibView
        
    }
    
}
