//
//  JDsaveKCController.swift
//  JDFragility
//
//  Created by apple on 2021/1/16.
//

import UIKit
import MJRefresh
class JDsaveKCController: JDBaseViewController, HeaderViewDelegate {
 


    @IBOutlet weak var letTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    
    var cfdBusListGUID : String?
    var cfdCourseId : String?
    var letftArr = [JDGroupModel]()
    var rightArr = [JDGroupModel]()
    var setedArr = [saveDetailModel]()
    var numberArr = [saveDetailModel]()
    var letfIndex : Int = 0;
    
    
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var allMoeny: UILabel!
    var ifdType : Int = 1
    
    var selectIndexs = Array<Any>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            setUI()
        setData()
        rightTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            if self.cfdCourseId == nil{
                self.rightTableView.mj_header?.endRefreshing()
                return
            }
            self.getCargarycfdCourseClassId(cfdCourseClassId: self.cfdCourseId ?? "")
         
        })
    }

}


extension JDsaveKCController:UITableViewDataSource,UITableViewDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{
    func setUI() {
        letTableView.delegate = self
        letTableView.dataSource = self
        letTableView.emptyDataSetSource = self
        letTableView.emptyDataSetDelegate = self
        rightTableView.delegate = self
        rightTableView.dataSource = self
        rightTableView.emptyDataSetSource = self
        rightTableView.emptyDataSetDelegate = self
        rightTableView.k_registerCell(cls: JDCourseshopingCell.classForCoder())
        letTableView.tableFooterView = UIView()
        rightTableView.tableFooterView = UIView()
        saveBtn.addAction { (_) in
            NHMBProgressHud.showSuccesshTips(message: "保存成功")
            let letModel = self.letftArr[self.letfIndex]
            
            let params = ["cfdMemberCardGUID":letModel.cfdMemberCardGUID ?? "","cfdCourseList":self.setedArr.kj.JSONString(),"cfdCourseStr":self.numberArr.kj.JSONString()]
            NetManager.ShareInstance.postWith(url: "api/IPad/IPadSaveMemberTimeList", params: params) { (dic) in

            } error: { (error) in

            }

        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == rightTableView{
        return rightArr.count
        }else{
            return 1
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == rightTableView {
            let group :JDGroupModel = rightArr[section]
    //            return group.isOpen == true ? group.list.count : 0
            return group.ItemList.count
        }else{
            return letftArr.count
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == rightTableView {
            return 110
        }else{
            return 50
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == letTableView{
 
            var cell = tableView.dequeueReusableCell(withIdentifier: "saveCellid")
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: "saveCellid")
            }
            let group  = letftArr[indexPath.row]
            cell?.textLabel?.text = group.cfdCourseName
            return cell!
        }else if tableView == rightTableView{
            let cell = tableView.k_dequeueReusableCell(cls: JDCourseshopingCell.self, indexPath: indexPath)
            cell.selectionStyle = .none;
            let rightMode  = rightArr[indexPath.section]
            cell.ifdType = ifdType
            cell.baocunModel = rightMode.ItemList[indexPath.row]
//            cell.delegate = self
            return cell
        }
        return UITableViewCell()
    }
    
//    func shopingaddjianCourse(type: Bool, model: JDGroupProjectModel) {
//
//    }
//
//    func saveCourse(isSeted: Bool, model: saveDetailModel) {
//        if isSeted == true {
//            setedArr.append(model)
//        }else{
//            setedArr.removeAll(where: { $0.cfdCourseListId == model.cfdCourseListId})
//        }
//    }
//
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == rightTableView {
        let header:HeaderView = HeaderView.headerViewWithTableView(tableView: tableView)
//         header.delegate = self
            header.backgroundColor=UIColor.k_colorWith(hexStr: "F7F8FA")
            header.group = rightArr[section];
         return header
     }
        return UIView()
    }
    
    func headerViewDidClickedNameView(headerView: HeaderView) {
        rightTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == rightTableView {
            if ifdType == 1 {
                allMoeny.isHidden = true
                return 50
            }else{
                allMoeny.isHidden = true
                return 0
            }
          
        }
      return 0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == letTableView {
            let group  = letftArr[indexPath.row]
            cfdCourseId = group.cfdCourseId
            rightTableView.mj_header?.beginRefreshing()
            self.setedArr.removeAll()
            self.numberArr.removeAll()
        }else{
            let group  = rightArr[indexPath.section]
            let groupDetail = group.ItemList[indexPath.row]
 
            if groupDetail.isseleted == true {
                groupDetail.isseleted = false
                setedArr.removeAll(where: { $0.cfdCourseListId == groupDetail.cfdCourseListId})
            }else{
                groupDetail.isseleted = true
                setedArr.append(groupDetail)
            }
            rightTableView.reloadData()
        }
    }
        func getCargarycfdCourseClassId(cfdCourseClassId:String)  {
            let params = ["cfdCourseId":cfdCourseClassId]
    
            NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryItemGroupList", params: params) { (dic) in
                self.rightTableView.mj_header?.endRefreshing()
                guard let arr = dic as? [[String : Any]] else { return }
                self.rightArr = arr.kj.modelArray(JDGroupModel.self)
                self.rightTableView.reloadData()
            
            } error: { (error) in
 
                self.rightTableView.mj_header?.endRefreshing()
                NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
            }

        }
    
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        UIImage(named: "zanwu")
    }
    
    
}
extension JDsaveKCController{
    func setData(){
        let params = ["cfdBusListGUID":cfdBusListGUID ?? "1ca9a06c-9704-4c55-b8b8-c68e9c5973c6" ]
        
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadBusListCourse", params: params) { (dic) in
            guard let arr = dic as? [[String : Any]] else { return }
            self.letftArr = arr.kj.modelArray(JDGroupModel.self)
            self.letTableView.reloadData()
            
            
            let letModel = self.letftArr[self.letfIndex]
         
            
            self.ifdType = letModel.ifdType  ?? 1
            self.cfdCourseId = letModel.cfdCourseId
            self.rightTableView.mj_header?.beginRefreshing()
            
//            let path = IndexPath(row: 0, section: 0)
//            self.letTableView.selectRow(at: path, animated: true, scrollPosition: .none)
        } error: { (error) in
            NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
        }

    }
 
}
