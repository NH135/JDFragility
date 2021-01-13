//
//  JDCourseController.swift
//  JDFragility
//
//  Created by apple on 2020/12/30.
//(课程购买)

import UIKit
import MJRefresh
class JDCourseController: JDBaseViewController, UITextFieldDelegate, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var rightTableView: UITableView!
    @IBOutlet weak var iconImageV: UIImageView!
    @IBOutlet weak var memberTelL: UILabel!
    @IBOutlet weak var memBerT: UITextField!
    @IBOutlet weak var goShopingBtn: UIButton!
    @IBOutlet weak var shopingView: UIView!
    @IBOutlet weak var zheBg: UIView!
    @IBOutlet weak var shopingTableView: UITableView!
    @IBOutlet weak var jiesuanBtn: UIButton!
    
    
    var cfdMemberId:String?
    
    var groups = Array<JDGroupModel>()
    var rightGroups = Array<JDGroupProjectModel>()
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
        memBerT.delegate = self
  leftTableView.delegate = self;
  leftTableView.dataSource = self;
        leftTableView.contentInset=UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
     leftTableView.k_registerCell(cls: JDgroupCell.classForCoder())
      rightTableView.delegate = self;
     rightTableView.dataSource = self;
          rightTableView.emptyDataSetSource = self;
        rightTableView.emptyDataSetDelegate = self
      rightTableView.contentInset=UIEdgeInsets(top: -20, left: 0, bottom: 20, right: 0)
        rightTableView.tableFooterView=UIView()
     rightTableView.k_registerCell(cls: JDCourseCell.classForCoder())
            setData()
        setRightshopingView()
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
            return rightGroups.count
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
            cell.detaileModel = rightGroups[indexPath.row]
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
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == leftTableView {
        let header:HeaderView = HeaderView.headerViewWithTableView(tableView: tableView)
         header.delegate = self
            header.backgroundColor=UIColor.k_colorWith(hexStr: "F7F8FA")
        header.group = groups[section]
         return header
     }
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            guard (cfdMemberId != nil) else {
                NHMBProgressHud.showSuccesshTips(message: "请先输入会员号码进行查询！")
                memBerT.becomeFirstResponder()
                return
            }
            
        let group  = groups[indexPath.section]
        let groupDetail = group.list[indexPath.row]
            classId = group.cfdCourseClassId
            rightTableView.mj_header?.beginRefreshing()
        }else{
            
        }
    }
    
    func getCargarycfdCourseClassId(cfdCourseClassId:String)  {
        let params = ["cfdCourseClassId":cfdCourseClassId]
      
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQCourseList", params: params) { (dic) in
            self.rightTableView.mj_header?.endRefreshing()
            guard let arr = dic as? [[String : Any]] else { return }
            self.rightGroups = arr.kj.modelArray(JDGroupProjectModel.self)
            self.rightTableView.reloadData()

        } error: { (error) in
            print(error)
        }

    }
    
    func headerViewDidClickedNameView(headerView: HeaderView) {
        self.leftTableView.reloadData()
    }
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        UIImage(named: "zanwu")
    }
}
extension JDCourseController{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == memBerT {
//         搜索会员
           
            memBerT.resignFirstResponder()
 
            NHMBProgressHud.showLoadingHudView(message: "加载中‘’‘’")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                NHMBProgressHud.hideHud()
            }
            let params = ["cfdMoTel": memBerT.text ?? ""]
            NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryMember", params: params) { (dic) in
                NHMBProgressHud.hideHud()
               
                guard let dics = dic as? [String : Any] else {
                    textField.text = ""
                    NHMBProgressHud.showSuccesshTips(message: "未查到该会员信息,请重新输入！")
                    return
                    
                }
//                self.reserveArr  = arr.kj.modelArray(JDreserverModel.self)
              
                let member =  dics.kj.model(MemberDetailModel.self)
                self.memberTelL.text = "\(member.cfdMemberName ?? "暂无")    \(member.cfdMoTel?.securePhoneStr ?? "暂无")"
                self.cfdMemberId = member.cfdMemberId
                self.tableView(self.leftTableView, didSelectRowAt: NSIndexPath(item: 0, section: 0) as IndexPath)
            } error: { (err) in
                DLog(err)
            }

            
        }
        
        return true
    }
    
}


extension JDCourseController{
    
    func setRightshopingView()  {
    
        zheBg.backgroundColor=UIColor.black.withAlphaComponent(0.7)
        goShopingBtn.addAction { (_) in
            UIView.animate(withDuration: 0.25) {
                self.shopingView.transform = CGAffineTransform(translationX: -300, y: 0)
            }
          
            self.zheBg.isHidden=false
        }
        
        zheBg.k_addTarget { (_) in
            UIView.animate(withDuration: 0.25) {
            self.shopingView.transform = CGAffineTransform.identity
            self.zheBg.isHidden = true
            }
        }
    }
    
}
//open
//public一般设置这个
//internal 默认
//fileprivate在当前文件
//private在当前定义体内

