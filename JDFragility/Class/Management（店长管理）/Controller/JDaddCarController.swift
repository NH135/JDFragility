//
//  JDaddCarController.swift
//  JDFragility
//
//  Created by apple on 2021/2/4.
//

import UIKit

class JDaddCarController: JDBaseViewController , DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{

    @IBOutlet weak var telF: UITextField!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var nameL: UIButton!
    @IBOutlet weak var iconI: UIImageView!
    
    @IBOutlet weak var allMoenyL: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var topH: NSLayoutConstraint!
    @IBOutlet weak var toptableView: UITableView!
    @IBOutlet weak var footertableView: UITableView!
    @IBOutlet weak var shenBtn: UIButton!
    @IBOutlet weak var shengBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    
    var shenList = [JDlingshengModel]()
    var shengList = [JDlingshengModel]()
    var gouList = [JDlingshengModel]()
    var cfdCardApplyGUID :String?
    
    var cfdCaiWuList = [JDlingshengModel]()
    var cfdMemberId :String?
    var cfdCourseId:String?
    
    var ifdApplyType = false //false领卡，true升卡
    var topSelectIndex : IndexPath?
    var footerSelectIndex : IndexPath?
    var goumaiIndexs = Array<Any>()
    var moeny :Int = 0
    var seltedMoeny :Int = 0
    var selteifdCumulativeMoney :Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.ifdApplyType == false {
            title = "领卡"
        }else{
            title = "升卡"
        }
        setUI()
    }


 
}
extension JDaddCarController{
    
    func setUI() {
 
        telF.delegate = self
        telF.k_limitTextLength = 11
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        tableView.k_registerCell(cls: JDshenglingCell.self)
        tableView.tableFooterView = UIView()
        
        toptableView.delegate = self
        toptableView.dataSource = self
        toptableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
        toptableView.k_registerCell(cls: JDlsCarCell.self)
        toptableView.tableFooterView = UIView()
        
        footertableView.delegate = self
        footertableView.dataSource = self
        footertableView.emptyDataSetSource = self
        footertableView.emptyDataSetDelegate = self
        footertableView.k_registerCell(cls: JDlsCarCell.self)
        footertableView.tableFooterView = UIView()
        footertableView.backgroundColor = UIColor.k_colorWith(hexStr: "#ECECEC")
        toptableView.backgroundColor = UIColor.k_colorWith(hexStr: "#ECECEC")
        shenBtn.addAction { (btn) in
            self.title = "升卡"
            self.moeny = 0
            self.seltedMoeny = 0
            self.allMoenyL.isHidden = true
            for m in self.shenList{
                m.isSeted = false
            }
            for m in self.shengList{
                m.isSeted = false
            }
            for m in self.gouList{
                m.isSeted = false
            }
            
            guard self.cfdMemberId != nil else{
                self.telF.becomeFirstResponder()
                NHMBProgressHud.showErrorMessage(message: "请先输入会员手机号进行查询")
                return
            }
            btn.isEnabled = false
            self.shengBtn.isEnabled = true
            self.topH.constant = 0
            self.toptableView.isHidden = true
            self.ifdApplyType = false
            self.toptableView.reloadData()
            self.footertableView.reloadData()
        }
        shengBtn.addAction { (btn) in
            self.title = "领卡"
            self.moeny = 0
            self.seltedMoeny = 0
            self.allMoenyL.isHidden = true
            for m in self.shenList{
                m.isSeted = false
            }
            for m in self.shengList{
                m.isSeted = false
            }
            for m in self.gouList{
                m.isSeted = false
            }
            
            guard self.cfdMemberId != nil else{
                self.telF.becomeFirstResponder()
                NHMBProgressHud.showErrorMessage(message: "请先输入会员手机号进行查询")
                return
            }
            btn.isEnabled = false
            self.shenBtn.isEnabled = true
        
            self.topH.constant = 190
            self.toptableView.isHidden = false
            self.ifdApplyType = true
            self.toptableView.reloadData()
            self.footertableView.reloadData()
        }
        
        submitBtn.addAction { (_) in
          
            
            if self.moeny - self.seltedMoeny > 0  || self.allMoenyL.isHidden == true || self.moeny == 0{
                
                NHMBProgressHud.showErrorMessage(message: "选择的购买记录不足以升级次卡")
                
             return
            }
             
            let cfdFendianId = UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""
            let cfdEmployeeId =  UserDefaults.standard.string(forKey: "cfdEmployeeId") ?? ""
            
            
            NHMBProgressHud.showLoadingHudView(message: "加载中～～")
            let params = ["cfdFendianId":cfdFendianId ,"ifdApplyType":self.ifdApplyType,"cfdCaiWu":self.cfdCaiWuList.kj.JSONString(),"cfdMemberId":self.cfdMemberId!,"cfdCourseId":self.cfdCourseId!,"cfdEmployeeId":cfdEmployeeId,"cfdOldCardApplyGUID":self.cfdCardApplyGUID ?? ""] as [String : Any]
              //获取查询已领取会员卡
              NetManager.ShareInstance.postWith(url: "api/IPad/IPadAddCardApply", params: params) { (dic) in
                  NHMBProgressHud.hideHud()
                if self.ifdApplyType == false {
                    NHMBProgressHud.showSuccesshTips(message: "申请成功！")
                }else{
                    NHMBProgressHud.showSuccesshTips(message: "升级成功！")
                }
             
                self.navigationController?.popViewController(animated: true)
              } error: { (error) in
                  NHMBProgressHud.hideHud()
                NHMBProgressHud.showErrorMessage(message: error as? String )
              }
        }
        searchBtn.addAction { (_) in
            self.setData()
        }
    }
    
    func setData() {
        view.endEditing(true)
        self.moeny = 0
        self.seltedMoeny = 0
        self.allMoenyL.isHidden = true
        //获取查询已领取会员卡
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryMyCardList", params: ["cfdMoTel":telF.text ?? ""]) { (dic) in
            NHMBProgressHud.hideHud()
        
            let lingArr = dic["CardList"] as? [[String : Any]]
           self.shengList  = lingArr?.kj.modelArray(JDlingshengModel.self) ?? [JDlingshengModel()]
           
           let arr = dic["CaiWuList"] as? [[String : Any]]
          self.gouList  = arr?.kj.modelArray(JDlingshengModel.self) ?? [JDlingshengModel()]
           
            let menberDic = dic["Member"] as? [String : Any]
            self.nameL .setTitle(menberDic!["cfdMemberName"] as? String , for: .normal)
            self.cfdMemberId = menberDic?["cfdMemberId"] as? String
           self.tableView.reloadData()
            self.toptableView.reloadData()
        } error: { (error) in
            NHMBProgressHud.hideHud()
        }
//        查询领卡申请卡级
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryCardList", params: nil) { (dic) in
            NHMBProgressHud.hideHud()
 
            let arr = dic as? [[String : Any]]
           self.shenList  = arr?.kj.modelArray(JDlingshengModel.self) ?? [JDlingshengModel()]
           
            self.footertableView.reloadData()
       
        } error: { (error) in
            NHMBProgressHud.hideHud()
        }
        
////        查询购买记录
//        //        9cb24ed5-ac6d-44b2-9760-143812c21292
//        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryCaiWuList", params: ["cfdMemberId":"9cb24ed5-ac6d-44b2-9760-143812c21292"]) { (dic) in
//            NHMBProgressHud.hideHud()
//
//
//        } error: { (error) in
//            NHMBProgressHud.hideHud()
//        }
        
    }
    
    
}
extension JDaddCarController:UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.setData()
    
        return true
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView  {
            return gouList.count
        }else if  tableView == self.footertableView  {
            return shenList.count
        }else{
            return shengList.count
        }
    }
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        UIImage(named: "zanwu")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView  {
            let cell = tableView.k_dequeueReusableCell(cls: JDshenglingCell.self, indexPath: indexPath)
            cell.gouModel = gouList[indexPath.row]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.lightText
            return cell
        }else if tableView == self.footertableView  {
            let cell = tableView.k_dequeueReusableCell(cls: JDlsCarCell.self, indexPath: indexPath)
            cell.shengModel = shenList[indexPath.row]
            cell.selectionStyle = .none
            cell.backgroundColor = UIColor.lightText
            return cell
        }else{
            let cell = tableView.k_dequeueReusableCell(cls: JDlsCarCell.self, indexPath: indexPath)
            cell.lingModel = shengList[indexPath.row]
            cell.backgroundColor = UIColor.lightText
            cell.selectionStyle = .none
            return cell
        } 
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
   
        if tableView == self.tableView  {
            let mode = gouList[indexPath.row]
            mode.isSeted = !mode.isSeted
            print(mode.isSeted)
            if mode.isSeted == true {
                seltedMoeny += mode.ffdIncome ?? 0
                cfdCaiWuList.append(mode)
            }else{
                seltedMoeny -= mode.ffdIncome ?? 0
                cfdCaiWuList.removeAll(where: { $0.ifdId == mode.ifdId})
            }
 
            self.allMoenyL.isHidden = false
            let lastmoeny = (moeny - seltedMoeny)>0 ? (moeny - seltedMoeny) : 0
            allMoenyL.text = "累计金额：¥\(moeny)   已选金额：¥\(seltedMoeny)   还差金额：¥\(lastmoeny)"
            self.tableView.reloadData()
        }else if tableView == self.footertableView  {
            if seltedMoeny == 0 && ifdApplyType == true  {
                NHMBProgressHud.showErrorMessage(message: "请先选择您要升级的卡")
                return
            }
            let mode = shenList[indexPath.row]
            if mode.ifdCumulativeMoney ?? 0 <=  selteifdCumulativeMoney{
                NHMBProgressHud.showErrorMessage(message: "不能升级为当前选择的卡级，请重新选择")
                return
            }
            
         
            if mode.isSeted == true {
                return
            }else{
                for m in shenList {
                    if m.cfdCourseId == mode.cfdCourseId {
                        m.isSeted = true
                        allMoenyL.isHidden = false
                        moeny = m.ifdCumulativeMoney ?? 0
                        allMoenyL.text = "累计金额：¥\(moeny)   已选金额：¥\(seltedMoeny)   还差金额：¥\(moeny - seltedMoeny>0 ? moeny - seltedMoeny : 0)"
                        cfdCourseId = mode.cfdCourseId ?? ""
//                        print("cfdCourseId====" + cfdCourseId!)
                    }else{
                    m.isSeted = false
                  
                    }
                }
            }
           
            self.footertableView.reloadData()
        }else{
            let mode = shengList[indexPath.row]
            cfdCardApplyGUID = mode.cfdCardApplyGUID
            if mode.isSeted == true {
                return
            }else{
                for m in shengList {
                    if m.cfdCourseId == mode.cfdCourseId {
                        m.isSeted = true
                        
                        selteifdCumulativeMoney = mode.ifdCumulativeMoney ?? 0
                        seltedMoeny += mode.ffdCardApplyMoney ?? 0
//                        moeny = m.ifdCumulativeMoney ?? 0
//                        allMoenyL.isHidden = false
//                        allMoenyL.text = "累计金额：¥\(moeny)   已选金额：¥\(seltedMoeny)   还差金额：¥\(moeny - seltedMoeny)"
                    }else{
                    m.isSeted = false
                    }
                }
//                mode.isSeted = true
            }
            self.toptableView.reloadData()
        }
            
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.tableView  {
           return 40
        }else{
            return 60
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == self.tableView  {
           return 40
        }else if tableView == self.toptableView  {
            if ifdApplyType == true {
                return 40
            }else{
                return 0
            }
     
        }else if tableView == self.footertableView  {
  
                return 40
            
        }
        return 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == self.tableView  {
      let xibView = Bundle.main.loadNibNamed("JDshenglingHeaderView", owner: nil, options: nil)?.first as! UIView
   
        xibView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 40)
      return xibView
        }else if tableView == self.toptableView  {
            let title = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
            title.backgroundColor = UIColor.white
            title.text = "      请选择您要升级的卡级"
            
            return title
        }else if tableView == self.footertableView  {
            let title = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 40))
            title.backgroundColor = UIColor.white
           
            if ifdApplyType == false {
                title.text = "      请选择您要申请的卡级"
            }else{
                title.text = "      升级为"
            }
            return title
        }
        return UIView()
    }
//
}
