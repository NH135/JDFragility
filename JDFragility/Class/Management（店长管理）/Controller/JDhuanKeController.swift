//
//  JDhuanKeController.swift
//  JDFragility
//
//  Created by apple on 2021/2/3.
//

import UIKit
import MJRefresh
class JDhuanKeController: JDBaseViewController, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    @IBOutlet weak var starTimeBtn: UIButton!
    @IBOutlet weak var endTimeBtn: UIButton!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var textF: UITextField!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var  starTime :String = ""
    var  endTime :String = ""
    var Keyword :String = ""
     
    var dataArr = [JDdianWuModel]()
    var page:Int = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "换课"
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
        tableView.tableFooterView = UIView()
        
        
        starTimeBtn.addAction { (btn:UIButton) in
            self.view.endEditing(true)
            let dataPicker = DateTimePickerView()
            dataPicker.pickerViewMode = DatePickerViewDateYearMonthDay
            dataPicker.timeStr = {(date) in
                self.starTimeBtn.setTitle("  \(date ?? "  请选择开始时间")", for: .normal)
                self.starTimeBtn.setTitleColor(UIColor.black, for: .normal)
                self.starTime = date ?? ""
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
                self.endTime = date ?? ""
            }
            dataPicker.show()
            Kwindow.window?.addSubview(dataPicker)
        }
        
        searchBtn.addAction { (_) in
            if self.starTime.isEmpty == true{
                    NHMBProgressHud.showErrorMessage(message: "请选择开始时间")
                    return
                }
                if self.endTime.isEmpty == true{
                    NHMBProgressHud.showErrorMessage(message: "请选择结束时间")
                    return
                }
         
            self.newData(page: self.page)
        }
        sureBtn.addAction { (_) in
            let addHuanKe = JDCourseController()
            addHuanKe.isHuanKe = true
            self.navigationController?.pushViewController(addHuanKe, animated: true)
            
        }
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.page = 1;
            self.newData(page: self.page)
            self.tableView.mj_footer?.endRefreshing()
            self.tableView.mj_header?.endRefreshing()
        })
        tableView.mj_header?.beginRefreshing()
        tableView.mj_footer = MJRefreshAutoGifFooter(refreshingBlock: {
            self.page += 1
            self.newData(page: self.page)
            self.tableView.mj_footer?.endRefreshing()
            self.tableView.mj_header?.endRefreshing()
        })
     }
    
    func newData(page:Int) {
        NHMBProgressHud.showLoadingHudView(message: "加载中～～")
        let cfdFendianId = UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""
        let params = ["cfdFendianId":cfdFendianId,"StartDateTime":self.starTime,"EndDateTime":self.endTime ,"page":self.page,"limit":"20","Keyword":self.Keyword] as [String : Any]


        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryChangeCourseList", params: params) { (dic) in
            NHMBProgressHud.hideHud()
         
            if self.page == 1{
                guard let arr = dic as? [[String : Any]] else { return }
                self.dataArr  = arr.kj.modelArray(JDdianWuModel.self)
            }else{
                guard let arr = dic as? [[String : Any]] else { return }
                var dArr = [JDdianWuModel]()
                dArr = arr.kj.modelArray(JDdianWuModel.self)
                if dArr.count == 0 {
                    self.tableView.mj_footer?.endRefreshingWithNoMoreData()
                }else{
                    self.dataArr  = self.dataArr + dArr
                }
                 
            }
            
      
            
            
            
       
            self.tableView.reloadData()
        } error: { (error) in
            NHMBProgressHud.hideHud()
        }

    }
  
 }
 extension JDhuanKeController:UITableViewDataSource,UITableViewDelegate{
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        UIImage(named: "zanwu")
    }
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArr.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.k_dequeueReusableCell(cls: JDlingshengCarCell.self, indexPath: indexPath)
         cell.backgroundColor = UIColor.lightText
        cell.huanKeModel = dataArr[indexPath.row]
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
