//
//  JDCourseController.swift
//  JDFragility
//
//  Created by apple on 2020/12/30.
//(课程购买)

import UIKit
import MJRefresh
class JDCourseController: JDBaseViewController {

    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    var groups = Array<JDGroupModel>()
    var classId : String?
     
//    lazy var groups: NSMutableArray? = {
//        var arr:NSMutableArray = NSMutableArray()
//        for i in 0..<4{
//            let group = JDGroupModel()
//            group.name = String(format: "组%d", i)
//
//            for i in 0...4{
//
//                let groupDetaile = JDGroupDetaileModel()
//                groupDetaile.name = String(format: "详情%d", i)
//                group.friends = NSMutableArray()
//                group.friends?.add(groupDetaile)
//            }
//
//            arr.add(group)
//        }
//        return arr
//    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor=UIColor.yellow
        self.leftTableView.delegate = self;
        self.leftTableView.dataSource = self;
//        self.leftTableView .register(JDgroupCell.classForCoder(), forCellReuseIdentifier: "groupsCellid")
        self.leftTableView.k_registerCell(cls: JDgroupCell.classForCoder())
        
        self.rightTableView.delegate = self;
        self.rightTableView.dataSource = self;
        self.rightTableView.contentInset=UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
//        self.leftTableView .register(JDgroupCell.classForCoder(), forCellReuseIdentifier: "groupsCellid")
        self.rightTableView.k_registerCell(cls: JDCourseCell.classForCoder())
         
            setData()
  
            rightTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
                if self.classId == nil{
                    self.rightTableView.mj_header?.endRefreshing()
                    return
                }
                self.getCargarycfdCourseClassId(cfdCourseClassId: self.classId ?? "")
            })
        }
        
        

 
}

extension JDCourseController{
    
    func setData()  {
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQCourseClassList", params: nil) { (dic) in
            guard let arr = dic as? [[String : Any]] else { return }
            self.groups  = arr.kj.modelArray(JDGroupModel.self)
            self.leftTableView.reloadData()
 
            self.tableView(self.leftTableView, didSelectRowAt: NSIndexPath(item: 0, section: 0) as IndexPath)
        } error: { (err) in
            print(err)
        }

    }
}

extension JDCourseController:UITableViewDataSource,UITableViewDelegate,HeaderViewDelegate{
      
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == leftTableView{
        return groups.count
        }else{
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView{
            
        let group :JDGroupModel = groups[section]
         
//            return group.isOpen == true ? group.list.count : 0
            return group.list.count
        }else{
            return 4
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == leftTableView{
            let cell = tableView.k_dequeueReusableCell(cls: JDgroupCell.self, indexPath: indexPath)
            
            let group  = groups[indexPath.section]
 
            cell.friendData = group.list[indexPath.row]
            return cell
        }else{
            let cell = tableView.k_dequeueReusableCell(cls: JDCourseCell.self, indexPath: indexPath)
            return cell
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == leftTableView {
            return 35
        }else{
            return 110
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == leftTableView {
        let header:HeaderView = HeaderView.headerViewWithTableView(tableView: tableView)
         header.delegate = self
        header.group = groups[section]
         return header
     }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let group  = groups[indexPath.section]
        
        let groupDetail = group.list[indexPath.row]
         
    getCargarycfdCourseClassId(cfdCourseClassId: groupDetail.cfdCourseClassId!)
    }
    
    func getCargarycfdCourseClassId(cfdCourseClassId:String)  {
        let params = ["cfdCourseClassId":cfdCourseClassId]
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQCourseList", params: params) { (dic) in
            print(dic)
            self.rightTableView.mj_header?.endRefreshing()
        } error: { (error) in
            print(error)
        }

    }
    
    func headerViewDidClickedNameView(headerView: HeaderView) {
        self.leftTableView.reloadData()
    }
    
}

//open
//public一般设置这个
//internal 默认
//fileprivate在当前文件
//private在当前定义体内

