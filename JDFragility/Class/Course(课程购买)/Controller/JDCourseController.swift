//
//  JDCourseController.swift
//  JDFragility
//
//  Created by apple on 2020/12/30.
//(课程购买)

import UIKit

class JDCourseController: JDBaseViewController {

    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    var groups = NSMutableArray()
    var isNet:Bool?
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
                for i in 0..<4{
                    let group = JDGroupModel()
                    group.name = String(format: "组%d", i)
 
//                    for i in 0...4{
//
//                        let groupDetaile = JDGroupDetaileModel()
//                        groupDetaile.name = String(format: "详情%d", i)
//                        group.friends = NSMutableArray()
//                        group.friends?.add(groupDetaile)
//                    }
        
                    groups.add(group)
                }
        
        
 
        self.leftTableView.delegate = self;
        self.leftTableView.dataSource = self;
//        self.leftTableView .register(JDgroupCell.classForCoder(), forCellReuseIdentifier: "groupsCellid")
        self.leftTableView.k_registerCell(cls: JDgroupCell.classForCoder())
        
        self.rightTableView.delegate = self;
        self.rightTableView.dataSource = self;
//        self.leftTableView .register(JDgroupCell.classForCoder(), forCellReuseIdentifier: "groupsCellid")
        self.rightTableView.k_registerCell(cls: JDCourseCell.classForCoder())
        if isNet == true {
            print("课程购买")
            setData()
        }
      
      
        }
        
        

 
}

extension JDCourseController{
    
    func setData()  {
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQCourseClassList", params: nil) { (dic) in
            DLog("课程购买\(dic)")
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
            
        let group :JDGroupModel = groups[section] as! JDGroupModel
        
        return group.isOpen == true ? 4 : 0
//        let num = group.friends?.count ?? 0
//          return num
        }else{
            return 4
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == leftTableView{
            let cell = tableView.k_dequeueReusableCell(cls: JDgroupCell.self, indexPath: indexPath)
            
//            let group  = groups[indexPath.section] as? JDGroupModel
            cell.textLabel?.text = "friendData!.name!"
     
    //        cell?.friendData = group?.friends![indexPath.row] as? JDGroupDetaileModel
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
        header.group = groups[section] as? JDGroupModel
         return header
     }
        return UIView()
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

