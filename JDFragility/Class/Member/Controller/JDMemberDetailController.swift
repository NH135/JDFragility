//
//  JDMemberDetailController.swift
//  JDFragility
//
//  Created by apple on 2021/1/8.
//

import UIKit
import IQKeyboardManager
import Kingfisher
class JDMemberDetailController: JDBaseViewController {
    @IBOutlet weak var iconImageV: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var scoureL: UILabel!
    @IBOutlet weak var creatL: UILabel!
    
    @IBOutlet weak var xieyiI: UIImageView!
    @IBOutlet weak var xieyiV: UIView!
    @IBOutlet weak var kedanB: UIButton!
    @IBOutlet weak var xiaofeiB: UIButton!
    @IBOutlet weak var cishuBtn: UIButton!
    @IBOutlet weak var chongzhiB: UIButton!
    @IBOutlet weak var chapingB: UIButton!
    @IBOutlet weak var dianpingB: UIButton!
    @IBOutlet weak var jiangeB: UIButton!
    @IBOutlet weak var oneV: UITableView!
    @IBOutlet weak var twoV: UITableView!
    @IBOutlet weak var threeV: UITableView!
    @IBOutlet weak var fourV: UITableView!
    @IBOutlet weak var fiveV: UITableView!
    @IBOutlet weak var oneB: UIButton!
    @IBOutlet weak var twoB: UIButton!
    @IBOutlet weak var threeB: UIButton!
    @IBOutlet weak var fourB: UIButton!
    @IBOutlet weak var fiveB: UIButton!
    
    @IBOutlet weak var kdnL: UILabel!
    @IBOutlet weak var kedanL: UILabel!
    @IBOutlet weak var csnL: UILabel!
    @IBOutlet weak var cishuL: UILabel!
    @IBOutlet weak var xfnL: UILabel!
    @IBOutlet weak var xiaofeiL: UILabel!
    @IBOutlet weak var cznL: UILabel!
    @IBOutlet weak var chongzhiL: UILabel!
    @IBOutlet weak var cpnL: UILabel!
    @IBOutlet weak var chapingL: UILabel!
    @IBOutlet weak var dpnL: UILabel!
    @IBOutlet weak var dianpingL: UILabel!
    @IBOutlet weak var jgnL: UILabel!
    @IBOutlet weak var jiangeL: UILabel!
    @IBOutlet weak var yuyueBtn: UIButton!
    @IBOutlet weak var huiyuanBtn: UIButton!

    @IBOutlet weak var kaidanBtn: UIButton!
    
    var memberModel = JDmemberModel()
    var vv = UIView()

    @IBOutlet weak var chongzhiBtn: UIButton!
//    var czView = JDCZView()
    
    
    var orderKCArr = [JDhuiyuanDetail]()
    var orderYFArr = [JDhuiyuanDetail]()
    var yhjArr = [JDhuiyuanDetail]()
    
    var lastKCArr = [TimeListModel]()
    var caozuoKCArr = [TimeListModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title="会员360"
        view.backgroundColor=UIColor.k_colorWith(hexStr: "#f8f8f8")
        setUI()
        setfooterUI()
        typeView(with: 1)
    }

}

extension JDMemberDetailController{
    
    
    
    //键盘弹起
      @objc func keyboardWillAppear(notification: NSNotification) {
  
          //设置中心点偏移
          UIView.animate(withDuration: 0.5) {
//              if y < 0 {
                  self.vv.origin.y = -200
//              }
          }
      }
      
      //键盘落下
      @objc func keyboardWillDisappear(notification:NSNotification){
 
          UIView.animate(withDuration: 0.5) {
              self.vv.origin.y = 0
          }
      }
    func searchData(){
        //         搜索会员
                   
        let params = ["cfdMoTel": memberModel.Member.cfdMoTel ?? "","cfdFendianId":UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""]
                    NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryMember360", params: params) { (dic) in
                        NHMBProgressHud.hideHud()
                        guard let dics = dic as? [String : Any] else {
                            
                            return
                        }
                        self.memberModel =  dics.kj.model(JDmemberModel.self)
                        self.nameL.text = self.memberModel.Member.cfdMemberName
                        //            (String(describing: MemberDic["cfdMemberName"]  ?? "暂无"))
                        self.scoureL.text = "客户来源:\(self.memberModel.Member.cfdSource ?? "")   手机号:\( self.memberModel.Member.cfdMoTel ?? "")"
                        self.creatL.text = "注册时间:\(self.memberModel.Member.dfdCreateDate?.k_subText(to: 10) ?? "暂无")   归属门店:\( self.memberModel.Member.cfdFendianName ?? "")   生日:\( self.memberModel.Member.dfdBirthday?.k_subText(to: 10) ?? "")  余额:¥ \( self.memberModel.Member.ffdBalance ?? "")"

                    } error: { (error) in
                        NHMBProgressHud.hideHud()
                        NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
                    }

                    
                }
    @objc func resh()  {
        searchData()
    }
    func setUI()  {
  
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
 
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(resh))
        iconImageV.cornerRadius(radius: 10)
        self.xieyiV.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        xieyiV.k_addTarget { (_) in
            self.xieyiV.isHidden = true
 
        }
        huiyuanBtn.addAction { (_) in
 
            self.xieyiV.isHidden = false
        }
       
        self.vv = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        self.vv.isHidden = true
        self.vv.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        Kwindow.window?.addSubview(self.vv)
        let coloseViewBtn = UIButton(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        
        self.vv.addSubview(coloseViewBtn)
 
        let czView = JDCZView.sg_loadFromNib() as! JDCZView
        czView.frame = CGRect(x: 150, y: 100, width: kScreenWidth-300, height: 500)
        czView.cornerRadius(radius:  10)
        self.vv.addSubview(czView)
 
  
        
        
     czView.iconI.setHeaderImageUrl(url: memberModel.Member.ImageUrl ?? "")
     czView.nameL.text = " \(memberModel.Member.cfdMemberName ?? "")/\( memberModel.Member.cfdMoTel ?? "")"
      czView.lastMoneyL.text = "当前余额：¥\(memberModel.Member.ffdBalance ?? "")"
      czView.mendianL.text = "充值门店：\(memberModel.Member.cfdFendianName ?? "")"
        chongzhiBtn.cornerRadius(radius: 15)
        chongzhiBtn.addAction { (_) in
            self.vv.isHidden = false
            czView.lastMoneyL.text = "当前余额：¥\(self.memberModel.Member.ffdBalance ?? "")"
//            self.vv.removeAllSubViews()
        }
        czView.closeBtn.addAction { (_) in
            
            for (_,textF) in czView.textArr.enumerated() {
                textF.text = ""
                
            }
            czView.MoneyL.text = "充值金额：¥0"
            self.vv.isHidden = true
 
            self.view.endEditing(true)
        }
        czView.sureB.addAction { (_) in
            UIApplication.shared.keyWindow?.endEditing(true)
            czView.allMoeny = 0
            for (_,textF) in czView.textArr.enumerated() {
                
                if textF.text?.k_isNumber == true {
                    czView.allMoeny  = czView.allMoeny + Int(textF.text ?? "0")!
                }
            }
          
            czView.MoneyL.text = "充值金额：¥\(czView.allMoeny)"
             
            if czView.allMoeny == 0{
                NHMBProgressHud.showErrorMessage(message: "请输入支付金额")
                return
            } 
            var moneyArr = [payModel]()
            for (_, item) in czView.textArr.enumerated(){
                
                    if item.text?.isEmpty == false {
                        var pmodel = payModel()
                        pmodel.ifdId = item.tag;
                        pmodel.ffdIncome = item.text ?? ""
                        moneyArr.append(pmodel)
                    }
            }
            
            NHMBProgressHud.showLoadingHudView(message: "加载中～～")
            
            let cfdEmployeeId = UserDefaults.standard.string(forKey: "cfdEmployeeId") ?? ""
            let cfdFendianId = UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""
            NetManager.ShareInstance.postWith(url: "api/IPad/IPadMemberRecharge", params: ["cfdMemberId":self.memberModel.Member.cfdMemberId ?? "","cfdEmployeeId":cfdEmployeeId,"cfdFendianId":cfdFendianId,"cfdCaiWustr":moneyArr.kj.JSONString()]) {  (_) in
                NHMBProgressHud.showSuccesshTips(message: "充值成功，请刷新查看")
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                self.vv.isHidden = true
                czView.MoneyL.text = "充值金额：¥0"
                for (_,textF) in czView.textArr.enumerated() {
                    textF.text = ""
                }
                self.searchData()
            } error: { (error) in
                NHMBProgressHud.showSuccesshTips(message: "转预付金转金额失败，请重试")
                NHMBProgressHud.hideHud()
            }

        }
        coloseViewBtn.addAction { (_) in
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            self.vv.isHidden = true
            czView.MoneyL.text = "充值金额：¥0"
            for (_,textF) in czView.textArr.enumerated() {
                textF.text = ""
                
            }
        }

        nameL.text = memberModel.Member.cfdMemberName
//            (String(describing: MemberDic["cfdMemberName"]  ?? "暂无"))
        scoureL.text = "客户来源:\(memberModel.Member.cfdSource ?? "")   手机号:\( memberModel.Member.cfdMoTel ?? "")"
        creatL.text = "注册时间:\(memberModel.Member.dfdCreateDate?.k_subText(to: 10) ?? "暂无")   归属门店:\( memberModel.Member.cfdFendianName ?? "")   生日:\( memberModel.Member.dfdBirthday?.k_subText(to: 10) ?? "")  余额:¥ \( memberModel.Member.ffdBalance ?? "")"
        yuyueBtn.cornerRadius(radius: 15)
        xieyiI.setCategorymageUrl(url: memberModel.Member.cfdAgreeMentImg ?? "")
        yuyueBtn.addAction { (_) in
            self.navigationController?.pushViewController(JDReservedController(), animated: true)
        }
        huiyuanBtn.cornerRadius(radius: 15)
      
        kaidanBtn.cornerRadius(radius: 15)
        kaidanBtn.addAction { (_) in
            let courseVC = JDCourseController()
            courseVC.title = "课程购买"
            courseVC.cfdMemberId = self.memberModel.Member.cfdMemberId
            courseVC.telStr = self.memberModel.Member.cfdMoTel
            courseVC.namelTelStr = self.memberModel.Member.cfdMemberName;
            self.navigationController?.pushViewController(courseVC, animated: true)
        }
        

        kedanL.wl_changeColor(withTextColor: UIColor.k_colorWith(hexStr: "cccccc"), changeText: "近1年")
        cishuL.wl_changeColor(withTextColor: UIColor.k_colorWith(hexStr: "cccccc"), changeText: "近1年")
        xiaofeiL.wl_changeColor(withTextColor: UIColor.k_colorWith(hexStr: "cccccc"), changeText: "近1年")
        chongzhiL.wl_changeColor(withTextColor: UIColor.k_colorWith(hexStr: "cccccc"), changeText: "近3个月")
        chapingL.wl_changeColor(withTextColor: UIColor.k_colorWith(hexStr: "cccccc"), changeText: "所有")
        dianpingL.wl_changeColor(withTextColor: UIColor.k_colorWith(hexStr: "cccccc"), changeText: "最后")
        jiangeL.wl_changeColor(withTextColor: UIColor.k_colorWith(hexStr: "cccccc"), changeText: "平均")
        kdnL.text = memberModel.UnitPrice ?? "0"   //1
        csnL.text = memberModel.MonthsNumber ?? "0"  //2
        xfnL.text = memberModel.ffdPayMoney ?? "0"  //3
        cznL.text = memberModel.ffdConMoney ?? "0"   //4
        cpnL.text = memberModel.BadNumber ?? "0"  //5
        dpnL.text = memberModel.LastDataTime ?? "0" //6
        jgnL.text = memberModel.CycleNumber ?? "0"  //7
//        iconImageV.kf.setImage(with: URL(string: memberModel.cfdPhoto ?? ""), placeholder: placeholderImage, options: nil, progressBlock: nil, completionHandler: nil)
        iconImageV.setHeaderImageUrl(url: memberModel.Member.cfdPhoto ?? "")
            oneB.addAction { (btn:UIButton) in
                btn.isEnabled=false
                self.twoB.isEnabled = true
                self.threeB.isEnabled = true
                self.fourB.isEnabled = true
                self.fiveB.isEnabled = true
                self.typeView(with: 1)
            }
        twoB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.oneB.isEnabled = true
            self.threeB.isEnabled = true
            self.fourB.isEnabled = true
            self.fiveB.isEnabled = true
            self.typeView(with: 2)
            
        }
        threeB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.twoB.isEnabled = true
            self.oneB.isEnabled = true
            self.fourB.isEnabled = true
            self.fiveB.isEnabled = true
            self.typeView(with: 3)
        }
        fourB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.twoB.isEnabled = true
            self.threeB.isEnabled = true
            self.oneB.isEnabled = true
            self.fiveB.isEnabled = true
            self.typeView(with: 4)
        }
        fiveB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.twoB.isEnabled = true
            self.threeB.isEnabled = true
            self.oneB.isEnabled = true
            self.fourB.isEnabled = true
            self.typeView(with: 5)
        }
    }
    func typeView(with type:NSInteger) {
        
         oneV.isHidden=true;
         twoV.isHidden=true;
         threeV.isHidden=true;
         fourV.isHidden=true;
        fiveV.isHidden = true
        switch type {
        case 1:
       oneV.isHidden=false;
            setShpingtype(type: "true")
        case 2:
            twoV.isHidden=false;
            lastKecheng()
        case 3:
           threeV.isHidden=false;
            setShpingtype(type: "false")
        case 4:
             fourV.isHidden=false;
            caozuo()
        default:
             fiveV.isHidden = false
            youhuijuan()
        }
    }

}
extension JDMemberDetailController:UITableViewDelegate,UITableViewDataSource, DZNEmptyDataSetSource, DZNEmptyDataSetDelegate,goumaikeSendDelegate{
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        UIImage(named: "zanwu")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == oneV {
            return self.orderKCArr.count
        }else if tableView == twoV {
            return lastKCArr.count
        }else if tableView == threeV {
            return self.orderYFArr.count
        }else if tableView == fiveV {
            return yhjArr.count
        }else {
            return caozuoKCArr.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == oneV {
            let mode  = orderKCArr[indexPath.row]
            return mode.goumaiHeight ?? 150
        }else if tableView == twoV {
            return 40
        }else if tableView == threeV {
            let mode  = orderYFArr[indexPath.row]
            return mode.goumaiHeight ?? 150
        }else if tableView == fiveV {
            return   120
        }else{
            return 40
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == twoV  ||  tableView == fourV{
            return 50
        }else   {
            return 0
        }
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == twoV{
            
            let headerV = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth-20, height: 50))
            headerV.backgroundColor=UIColor.white
            let width = (kScreenWidth-440)/6
            let numbs = ["总次数","操作次数","退课次数","换课次数","冻结次数","剩余次数"]
            let numbsone = ["日期","课程套餐","项目名称"]
            for(index,item) in numbsone.enumerated() {
                let tit = UILabel(frame: CGRect(x: 140 * CGFloat(index) , y: 0, width: 140, height: 50))
               
                tit.text = item
                tit.textAlignment = .center
                headerV.addSubview(tit)
            }
            for (index,item) in numbs.enumerated() {
                let titt = UILabel(frame: CGRect(x: 420 + width * CGFloat(index) , y: 0, width: width, height: 50))
               
                titt.text = item
                titt.textAlignment = .center
                headerV.addSubview(titt)
            }
            let line = UIView(frame: CGRect(x: 0, y: 49, width: kScreenWidth, height: 0.5))
            headerV.addSubview(line)
            line.backgroundColor=UIColor.k_colorWith(hexStr: "e1e1e1")
            return headerV;
        }else  if  tableView == fourV {
            let headerV = UIView(frame: CGRect(x: 0, y: 0, width: kScreenWidth-20, height: 50))
            headerV.backgroundColor=UIColor.white
            let width = (kScreenWidth-20)/6
            let numbs = ["日期","分店名称","课程名称","操作项目","操作员工","操作次数"]
           
            for(index,item) in numbs.enumerated() {
                let tit = UILabel(frame: CGRect(x: width * CGFloat(index) , y: 0, width: width, height: 50))
                tit.text = item
                tit.textAlignment = .center
                headerV.addSubview(tit)
            }
             
            let line = UIView(frame: CGRect(x: 0, y: 49, width: kScreenWidth, height: 0.5))
            headerV.addSubview(line)
            line.backgroundColor=UIColor.k_colorWith(hexStr: "e1e1e1")
            return headerV;
        }else{
            return UIView();
        }
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == oneV {
            let cell = tableView.k_dequeueReusableCell(cls: JDgoumaikcCell.self, indexPath: indexPath)
            cell.selectionStyle = .none
            cell.ifdType = true;
            cell.goumaiModel = orderKCArr[indexPath.row]
            cell.delegate = self
            return cell
        }else  if tableView == twoV {
            let cell = tableView.k_dequeueReusableCell(cls: JDlasteCaozuowCell.self, indexPath: indexPath)
            cell.lastModel = lastKCArr[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }else  if tableView == threeV {
            let cell = tableView.k_dequeueReusableCell(cls: JDgoumaikcCell.self, indexPath: indexPath)
            cell.selectionStyle = .none
            cell.delegate = self
            cell.ifdType = false;
             cell.yufuModel = orderYFArr[indexPath.row]
            return cell
        }else if tableView == fourV{
            let cell = tableView.k_dequeueReusableCell(cls: JDNewcaozuoCell.self, indexPath: indexPath)
            cell.selectionStyle = .none
            cell.lastModel = caozuoKCArr[indexPath.row]
            return cell
        }
        else  {
            let cell = tableView.k_dequeueReusableCell(cls: JDDetaileYhjCell.self, indexPath: indexPath)
            cell.selectionStyle = .none
            cell.yhjModel = yhjArr[indexPath.row]
            return cell
        }
          
    }
    func reserveSendName(btn:UIButton,reserveMode:JDhuiyuanDetail){
        print()
        if btn.titleLabel?.text! == "预付金转金额" {
            JXTAlertView.show(withTitle: "提示", message: "是否申请转预付金转金额", cancelButtonTitle: "取消", otherButtonTitle: "确定") { (_) in
                
            } otherButtonBlock: { (_) in
                NHMBProgressHud.showLoadingHudView(message: "加载中～～")
                
                let cfdEmployeeId = UserDefaults.standard.string(forKey: "cfdEmployeeId") ?? ""
                let cfdFendianId = UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""
                NetManager.ShareInstance.postWith(url: "api/IPad/IPadEditBusListApply", params: ["cfdBusListGUID":reserveMode.cfdBusListGUID ?? "","cfdEmployeeId":cfdEmployeeId,"cfdFendianId":cfdFendianId]) { [self] (_) in
                    NHMBProgressHud.hideHud()
                    NHMBProgressHud.showSuccesshTips(message: "转预付金转金额成功！")
                    for (index,item) in orderYFArr.enumerated(){
                        
                        if item.cfdBusListGUID == reserveMode.cfdBusListGUID {
                            orderYFArr.remove(at: index)
                            self.threeV.reloadData()
                            break
                        }
                    }
                    
                } error: { (error) in
                    NHMBProgressHud.showSuccesshTips(message: "转预付金转金额失败，请重试")
                    NHMBProgressHud.hideHud()
                }

            }
        }else  if btn.titleLabel?.text! == "选课程" {
            let save =  JDsaveKCController()
            save.cfdBusListGUID = reserveMode.cfdBusListGUID 

            self.navigationController?.ymPushViewController(save, removeSelf: true, animated: true)
        }else{
            let settlement = JDSettlementController()
            settlement.cfdBusListGUID  = reserveMode.cfdBusListGUID!
            settlement.memberModel = self.memberModel.Member;
              settlement.isYf = true
            self.navigationController?.pushViewController(settlement, animated: true)
        }
        

    }
    func setfooterUI(){
        oneV.delegate = self
        twoV.delegate = self
        oneV.emptyDataSetSource = self
        oneV.emptyDataSetDelegate = self
        twoV.emptyDataSetSource = self
        twoV.emptyDataSetDelegate = self
        threeV.emptyDataSetSource = self
        threeV.emptyDataSetDelegate = self
        fourV.emptyDataSetSource = self
        fourV.emptyDataSetDelegate = self
        fiveV.emptyDataSetSource = self
        fiveV.emptyDataSetDelegate = self
        fiveV.delegate = self
        fiveV.dataSource = self
        threeV.delegate = self
        fourV.delegate = self
        oneV.dataSource = self
        twoV.dataSource = self
        threeV.dataSource = self
        fourV.dataSource = self
        
        oneV.k_registerCell(cls: JDgoumaikcCell.self)
        oneV.tableFooterView = UIView()
        threeV.k_registerCell(cls: JDgoumaikcCell.self)
        threeV.tableFooterView = UIView()
        twoV.tableFooterView = UIView()
        fourV.tableFooterView = UIView()
        fiveV.tableFooterView = UIView()
        twoV.k_registerCell(cls: JDlasteCaozuowCell.self)
        fourV.k_registerCell(cls: JDNewcaozuoCell.self)
        fiveV.k_registerCell(cls: JDDetaileYhjCell.self)
     
        
//         fourV.tableHeaderView = headerV;
        
        
        
        
    }
    
    func setShpingtype(type:NSString) {
        NHMBProgressHud.showLoadingHudView(message: "加载中～～")
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryBusList", params: ["cfdMemberId":self.memberModel.Member.cfdMemberId ?? "","ifdType":type ]) { (dic) in
   
            NHMBProgressHud.hideHud()
            guard let arr = dic as? [[String : Any]] else { return }
            if type == "true"{
                self.orderKCArr  = arr.kj.modelArray(JDhuiyuanDetail.self)
                self.oneV.reloadData()
            }else{
                self.orderYFArr  = arr.kj.modelArray(JDhuiyuanDetail.self)
                self.threeV.reloadData()
            }
        } error: { (error) in
            NHMBProgressHud.hideHud()
        }

    }
    func lastKecheng() {
        
        NHMBProgressHud.showLoadingHudView(message: "加载中～～")
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQMemberTimeList", params: ["cfdMemberId":self.memberModel.Member.cfdMemberId ?? ""  ]) { (dic) in
            print(dic)
            NHMBProgressHud.hideHud()
            guard let arr = dic as? [[String : Any]] else { return }
 
                self.lastKCArr  = arr.kj.modelArray(TimeListModel.self)
                self.twoV.reloadData()
 
        } error: { (error) in
            NHMBProgressHud.hideHud()
        }

        
    }
    
    
    func caozuo() {
        
        NHMBProgressHud.showLoadingHudView(message: "加载中～～")
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQTimeUseList", params: ["cfdMemberId":self.memberModel.Member.cfdMemberId ?? ""  ]) { (dic) in
            print(dic)
            NHMBProgressHud.hideHud()
            guard let arr = dic as? [[String : Any]] else { return }
                self.caozuoKCArr  = arr.kj.modelArray(TimeListModel.self)
                self.fourV.reloadData()
        } error: { (error) in
            NHMBProgressHud.hideHud()
        }
    }
    
    func youhuijuan() {
        
        NHMBProgressHud.showLoadingHudView(message: "加载中～～")
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryTokenList", params: ["cfdMemberId":self.memberModel.Member.cfdMemberId ?? ""  ]) { (dic) in
            print(dic)
            NHMBProgressHud.hideHud()
            guard let arr = dic as? [[String : Any]] else { return }
                self.yhjArr  = arr.kj.modelArray(JDhuiyuanDetail.self)
                self.fiveV.reloadData()
        } error: { (error) in
            NHMBProgressHud.hideHud()
        }
    }
}
