//
//  JDCourseController.swift
//  JDFragility
//
//  Created by apple on 2020/12/30.
//(课程购买)

import UIKit
import MJRefresh
import KakaJSON
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
    
    var memberModel = MemberDetailModel()
    
    var cfdMemberId:String?
    var shopingGroups = Array<JDGroupProjectModel>()
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
        leftTableView.emptyDataSetSource = self;
        leftTableView.emptyDataSetDelegate = self
        leftTableView.tableFooterView=UIView()
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
        NHMBProgressHud.showLoadingHudView(message: "加载中···")
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQCourseClassList", params: nil) { (dic) in
            NHMBProgressHud.hideHud()
            guard let arr = dic as? [[String : Any]] else { return }
            self.groups  = arr.kj.modelArray(JDGroupModel.self)
            self.leftTableView.reloadData()
 

        } error: { (err) in
            print(err)
            NHMBProgressHud.hideHud()
            NHMBProgressHud.showErrorMessage(message: "加载失败")
        }

    }
}

extension JDCourseController:UITableViewDataSource,UITableViewDelegate,HeaderViewDelegate,courseAddDelegate{
 
      
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
        }else if tableView == rightTableView{
            return rightGroups.count
        }else{
            return shopingGroups.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if tableView == leftTableView{
            let cell = tableView.k_dequeueReusableCell(cls: JDgroupCell.self, indexPath: indexPath)
            
            let group  = groups[indexPath.section]
 
            cell.friendData = group.list[indexPath.row]
            return cell
        }else if tableView == rightTableView{
            let cell = tableView.k_dequeueReusableCell(cls: JDCourseCell.self, indexPath: indexPath)
            cell.selectionStyle = .none;
            cell.detaileModel = rightGroups[indexPath.row]
            cell.delegate = self
            return cell
        }else{
            let cell = tableView.k_dequeueReusableCell(cls: JDCourseshopingCell.self, indexPath: indexPath)
            cell.detaileModel = shopingGroups[indexPath.row]
//            cell.delegate = self
            cell.selectionStyle = .none;
            return cell
        }
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == leftTableView {
            return 35
        }else if tableView == rightTableView {
            return 110
        }else{
            return 90
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
//            print(error)
            self.rightTableView.mj_header?.endRefreshing()
//            NHMBProgressHud.showErrorMessage(message: String(error) ?? "获取失败" )
        }

    }
    
    func headerViewDidClickedNameView(headerView: HeaderView) {
        self.leftTableView.reloadData()
    }
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        UIImage(named: "zanwu")
    }
    
    
    func addjianCourse(type: Bool, model: JDGroupProjectModel) {
        if type == true {
         self.shopingGroups.append(model)
        }else{
            self.shopingGroups.removeAll(where: { $0.cfdCourseClassId == model.cfdCourseClassId})
        }
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
              
                self.memberModel =  dics.kj.model(MemberDetailModel.self)
                self.memberTelL.text = "\(self.memberModel.cfdMemberName ?? "暂无")    \(self.memberModel.cfdMoTel?.securePhoneStr ?? "暂无")"
                self.cfdMemberId = self.memberModel.cfdMemberId
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
        self.shopingTableView.delegate = self
        self.shopingTableView.dataSource = self
        self.shopingTableView.emptyDataSetSource = self
        self.shopingTableView.emptyDataSetDelegate = self
        self.shopingTableView.k_registerCell(cls: JDCourseshopingCell.classForCoder())
 
        
//        购物车
        goShopingBtn.addAction { (_) in
            self.shopingTableView.reloadData()
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
        
        
        
        jiesuanBtn.addAction { (_) in
//            let settlement = JDSettlementController()
//            settlement.cfdBusListGUID  = (dic["cfdBusListGUID"] as! String)
//            settlement.memberModel = self.memberModel;
//            self.navigationController?.pushViewController(settlement, animated: true)
//
//            retu
//
//
            guard self.shopingGroups.count != 0  else {
                NHMBProgressHud.showErrorMessage(message: "请购买项目")
                return }
            
            let cfdFendianId = UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""
            let cfdEmployeeId = UserDefaults.standard.string(forKey: "cfdEmployeeId") ?? ""
            let aa : String = self.shopingGroups.kj.JSONString()


            let params = ["cfdFendianId":cfdFendianId ,"cfdEmployeeId":cfdEmployeeId,"cfdMemberId":self.cfdMemberId,"cfdCourseStr":aa]
            
          
            NetManager.ShareInstance.postWith(url: "api/IPad/IPadAddBusList", params: params as [String : Any]) { (dic) in
                print(dic)
                self.shopingGroups.removeAll()
                self.shopingTableView.reloadData()
                self.getCargarycfdCourseClassId(cfdCourseClassId: self.classId ?? "")
                let settlement = JDSettlementController()
                settlement.cfdBusListGUID  = (dic["cfdBusListGUID"] as! String)
                settlement.memberModel = self.memberModel;
                self.navigationController?.pushViewController(settlement, animated: true)

            } error: { (error) in
                print(error )
            }

        }
    }
 
    func ObjectToJSONString(object: Any) -> String? {
        do {
            let data = try JSONSerialization.data(withJSONObject: object, options: []);
            let JSONString = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue));
            return JSONString;
        } catch {
            print(error);
        }
        return nil;
    }

    
}
//open
//public一般设置这个
//internal 默认
//fileprivate在当前文件
//private在当前定义体内

