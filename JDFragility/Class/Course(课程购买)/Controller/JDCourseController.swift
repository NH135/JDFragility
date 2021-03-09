//
//  JDCourseController.swift
//  JDFragility
//
//  Created by apple on 2020/12/30.
//(课程购买)

import UIKit
import MJRefresh
import KakaJSON
import IQKeyboardManager
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
    @IBOutlet weak var searchBtn: UIButton!
    
    var TimeList = [JDGroupProjectModel]()
    var isHuanKe = false
    var ffdBalance :String?
    
    @IBOutlet weak var topH: NSLayoutConstraint!
    var memberModel = MemberDetailModel()
    
    var cfdMemberId:String?
    var telStr:String?
    var namelTelStr:String?
    var shopingGroups = Array<JDGroupProjectModel>()
    var groups = Array<JDGroupModel>()
    var rightGroups = Array<JDGroupProjectModel>()
    var classId : String?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().isEnabled = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        IQKeyboardManager.shared().isEnabled = true
        rightTableView.mj_header?.beginRefreshing()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "课程购买"
        if isHuanKe == true {
            title = "换课"
        }
        memBerT.text = telStr
        iconImageV.cornerRadius(radius: 20)
        view.backgroundColor=UIColor.k_colorWith(hexStr: "e1e1e1")
        let headerV  = UIView(frame: CGRect(x: 0, y: 0, width: 280, height: 55))
        headerV.backgroundColor=UIColor.k_colorWith(hexStr: "#409EFF")
        leftTableView.tableHeaderView = headerV;
        let tiL = UILabel(frame: CGRect(x: 12, y: 0, width: 100, height: 55))
        tiL.text = "类别"
        tiL.font=UIFont.systemFont(ofSize: 18)
        tiL.textColor=UIColor.white
        headerV.addSubview(tiL)
        memBerT.k_limitTextLength = 11
        memBerT.delegate = self
        leftTableView.delegate = self;
        leftTableView.dataSource = self;
        leftTableView.tableFooterView=UIView()
        leftTableView.contentInset=UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        leftTableView.k_registerCell(cls: JDgroupCell.classForCoder())
        rightTableView.delegate = self;
        rightTableView.dataSource = self;
        rightTableView.emptyDataSetSource = self;
        rightTableView.emptyDataSetDelegate = self
        rightTableView.contentInset=UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        rightTableView.tableFooterView=UIView()
        rightTableView.k_registerCell(cls: JDCourseCell.classForCoder())
        setData()
        setRightshopingView()
        rightTableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            if self.classId == nil{
                self.rightTableView.mj_header?.endRefreshing()
                
                return
            }
            self.search()
            self.getCargarycfdCourseClassId(cfdCourseClassId: self.classId ?? "")
        })
        searchBtn.addAction { (_) in
            self.search()
        }
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
            if self.namelTelStr?.isEmpty == false {
                self.tableView(self.leftTableView, didSelectRowAt: NSIndexPath(item: 0, section: 0) as IndexPath)
                self.memberTelL.text = self.namelTelStr ?? "请输入会员手机号进行查询：";
                self.memBerT.becomeFirstResponder()
            }
            
            
        } error: { (error) in
            
            NHMBProgressHud.hideHud()
            NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if tableView == shopingTableView{
            if editingStyle == UITableViewCell.EditingStyle.delete {
                shopingGroups.remove(at: indexPath.row)
                shopingTableView.reloadData()
                //                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableView.RowAnimationn.Fade)
            }
        }
    }
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        "删除"
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView == shopingTableView{
            return true
        }
        return false
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView{
            
            let group :JDGroupModel = groups[section]
            
            return group.isOpen == true ? group.list.count : 0
            
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
            //            cell.selectedBackgroundView.backgroundColor=[UIColor blackColor];
            cell.selectedBackgroundView = UIView()
            cell.selectedBackgroundView?.backgroundColor =
                UIColor.k_colorWith(hexStr: "#A0CFFF")
            cell.textLabel?.highlightedTextColor = UIColor.white
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
            return 50
        }else if tableView == rightTableView {
            return 110
        }else{
            return 90
        }
    }
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == leftTableView {
            let header:HeaderView = HeaderView.headerViewWithTableView(tableView: tableView)
            header.delegate = self
            
            header.backgroundColor=UIColor.k_colorWith(hexStr: "#F7F8FA")
            header.group = groups[section]
            return header
        }
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == leftTableView {
            return 50
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == leftTableView {
            
            let group  = groups[indexPath.section]
            let groupDetail = group.list[indexPath.row]
            guard (cfdMemberId != nil) else {
                classId = groupDetail.cfdCourseClassId
                NHMBProgressHud.showSuccesshTips(message: "请先输入会员号码进行查询！")
                memBerT.becomeFirstResponder()
                return
            }
            
            
            
            classId = groupDetail.cfdCourseClassId
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
            self.rightTableView.mj_header?.endRefreshing()
            NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
        }
        
    }
    
    func headerViewDidClickedNameView(model:JDGroupModel,isSted:Bool) {
        
        for m in groups {
            m.isOpen = false
            if m.cfdCourseClassId == model.cfdCourseClassId {
                m.isOpen = isSted
            }
        }
        
        self.leftTableView.reloadData()
    }
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        UIImage(named: "zanwu")
    }
    
    
    func addjianCourse(type: Bool, model: JDGroupProjectModel) {
        if type == true {
            self.shopingGroups.append(model)
        }else{
            for (index,m) in shopingGroups.enumerated() {
                if m.cfdCourseClassId == model.cfdCourseClassId {
                    shopingGroups.remove(at: index)
                    break
                }
            }
        }
    }
}
extension JDCourseController{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == memBerT {
            search()
        }
        
        return true
    }
    
    func search() {
        view.endEditing(true)
        guard memBerT.text?.length == 11 else {
            NHMBProgressHud.showErrorMessage(message: "请输入正确的手机号")
            return
        }
        //         搜索会员
        
        NHMBProgressHud.showLoadingHudView(message: "加载中‘’‘’")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            NHMBProgressHud.hideHud()
        }
        let params = ["cfdMoTel": memBerT.text ?? ""]
        
        
        if isHuanKe {
            NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryMemberCourse", params: params) { (dic) in
                NHMBProgressHud.hideHud()
                
                guard let dics = dic as? [String : Any] else {
                    self.memBerT.text = ""
                    NHMBProgressHud.showSuccesshTips(message: "未查到该会员信息,请重新输入！")
                    return
                    
                }
                let Memberdic = dics["Member"] as? [String : Any]
                self.memberModel =  Memberdic?.kj.model(MemberDetailModel.self) ?? MemberDetailModel()
                self.iconImageV.setHeaderImageUrl(url: self.memberModel.cfdPhoto ?? "")
                self.memberTelL.text = "\(self.memberModel.cfdMemberName ?? "暂无")    \(self.memberModel.cfdMoTel?.securePhoneStr ?? "暂无")"
                self.cfdMemberId = self.memberModel.cfdMemberId
                self.rightTableView.mj_header?.beginRefreshing()
                self.ffdBalance = self.memberModel.ffdBalance
                let TimeListArr = dics["TimeList"] as? [[String : Any]]
                self.TimeList = TimeListArr?.kj.modelArray(JDGroupProjectModel.self) ?? [JDGroupProjectModel()]
                
            } error: { (error) in
                NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
            }
            
        }else{
            
            NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryMember", params: params) { (dic) in
                NHMBProgressHud.hideHud()
                
                guard let dics = dic as? [String : Any] else {
                    self.memBerT.text = ""
                    NHMBProgressHud.showSuccesshTips(message: "未查到该会员信息,请重新输入！")
                    return
                    
                }
                self.memberModel =  dics.kj.model(MemberDetailModel.self)
                self.memberTelL.text = "\(self.memberModel.cfdMemberName ?? "暂无")    \(self.memberModel.cfdMoTel?.securePhoneStr ?? "暂无")"
                self.view.endEditing(true)
                self.iconImageV.setHeaderImageUrl(url: self.memberModel.cfdPhoto ?? "")
                self.cfdMemberId = self.memberModel.cfdMemberId
                //                self.tableView(self.leftTableView, didSelectRowAt: NSIndexPath(item: 0, section: 0) as IndexPath)
                self.rightTableView.mj_header?.beginRefreshing()
            } error: { (error) in
                NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
            }
            
        }
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
        shopingTableView.tableFooterView = UIView()
        //        购物车
        goShopingBtn.addAction { (_) in
            //            let save =  JDsaveKCController()
            //            save.cfdBusListGUID = "d584880b-f388-4b43-9c11-f564b5930111"  //金额
            ////          save.cfdBusListGUID = "f8e35198-ccc0-4c32-86fe-0f46940b0614"  //多选
            //            self.navigationController?.pushViewController(save, animated: true)
            
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
            guard self.shopingGroups.count != 0  else {
                NHMBProgressHud.showErrorMessage(message: "请购买项目")
                return }
            
            if self.isHuanKe == true {
                //              "换课"
                let huanSave = JDhuanKeSaveController()
                huanSave.shopingGroups = self.shopingGroups
                huanSave.TimeList = self.TimeList
                huanSave.cfdMemberId = self.cfdMemberId ?? ""
                huanSave.yueStr = self.ffdBalance ?? ""
                self.navigationController?.ymPushViewController(huanSave, removeSelf: true, animated: true)
                
                
            }else{
                let cfdFendianId = UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""
                let cfdEmployeeId = UserDefaults.standard.string(forKey: "cfdEmployeeId") ?? ""
                let aa : String = self.shopingGroups.kj.JSONString()
                
                
                let params = ["cfdFendianId":cfdFendianId ,"cfdEmployeeId":cfdEmployeeId,"cfdMemberId":self.cfdMemberId,"cfdCourseStr":aa]
                
                NHMBProgressHud.showLoadingHudView(message: "正在生成账单～～")
                NetManager.ShareInstance.postWith(url: "api/IPad/IPadAddBusList", params: params as [String : Any]) { (dic) in
                    NHMBProgressHud.hideHud()
                    self.shopingGroups.removeAll()
                    self.shopingTableView.reloadData()
                    self.getCargarycfdCourseClassId(cfdCourseClassId: self.classId ?? "")
                    let settlement = JDSettlementController()
                    settlement.cfdBusListGUID  = (dic["cfdBusListGUID"] as! String)
                    settlement.memberModel = self.memberModel;
                    self.navigationController?.pushViewController(settlement, animated: true)
                    UIView.animate(withDuration: 0.25) {
                        self.shopingView.transform = CGAffineTransform.identity
                        self.zheBg.isHidden = true
                    }
                } error: { (error) in
                    NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
                }
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

