//
//  JDMemberDetailController.swift
//  JDFragility
//
//  Created by apple on 2021/1/8.
//

import UIKit
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
    @IBOutlet weak var oneB: UIButton!
    @IBOutlet weak var twoB: UIButton!
    @IBOutlet weak var threeB: UIButton!
    @IBOutlet weak var fourB: UIButton!
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
    
    
    
    var orderKCArr = [JDhuiyuanDetail]()
    var orderYFArr = [JDhuiyuanDetail]()
    
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
    func setUI()  {
        iconImageV.cornerRadius(radius: 10)
        self.xieyiV.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        xieyiV.k_addTarget { (_) in
            self.xieyiV.isHidden = true
        }
        huiyuanBtn.addAction { (_) in
            self.xieyiV.isHidden = false
        }
        nameL.text = memberModel.Member.cfdMemberName
//            (String(describing: MemberDic["cfdMemberName"]  ?? "暂无"))
        scoureL.text = "客户来源:\(memberModel.Member.cfdSource ?? "")   手机号:\( memberModel.Member.cfdMoTel ?? "")"
        creatL.text = "注册时间:\(memberModel.Member.dfdCreateDate?.k_subText(to: 10) ?? "暂无")   归属门店:\( memberModel.Member.cfdFendianName ?? "")   生日:\( memberModel.Member.dfdBirthday?.k_subText(to: 10) ?? "")"
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
                self.typeView(with: 1)
            }
        twoB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.oneB.isEnabled = true
            self.threeB.isEnabled = true
            self.fourB.isEnabled = true
            self.typeView(with: 2)
        }
        threeB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.twoB.isEnabled = true
            self.oneB.isEnabled = true
            self.fourB.isEnabled = true
            self.typeView(with: 3)
        }
        fourB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.twoB.isEnabled = true
            self.threeB.isEnabled = true
            self.oneB.isEnabled = true
            self.typeView(with: 4)
        }
        
    }
    func typeView(with type:NSInteger) {
        
        self.oneV.isHidden=true;
        self.twoV.isHidden=true;
        self.threeV.isHidden=true;
        self.fourV.isHidden=true;
       
        switch type {
        case 1:
            self.oneV.isHidden=false;
            setShpingtype(type: "true")
        case 2:
            self.twoV.isHidden=false;
            lastKecheng()
        case 3:
            self.threeV.isHidden=false;
            setShpingtype(type: "false")
        default:
            
            self.fourV.isHidden=false;
            caozuo()
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
            let mode  = orderKCArr[indexPath.row]
            return mode.goumaiHeight ?? 150
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
            return cell
        }else  if tableView == twoV {
            let cell = tableView.k_dequeueReusableCell(cls: JDlasteCaozuowCell.self, indexPath: indexPath)
            cell.lastModel = lastKCArr[indexPath.row]
  
        }else  if tableView == threeV {
            let cell = tableView.k_dequeueReusableCell(cls: JDgoumaikcCell.self, indexPath: indexPath)
            cell.selectionStyle = .none
            cell.delegate = self
            cell.ifdType = false;
        cell.yufuModel = orderYFArr[indexPath.row]
            return cell
        }else  {
            let cell = tableView.k_dequeueReusableCell(cls: JDNewcaozuoCell.self, indexPath: indexPath)
            cell.lastModel = caozuoKCArr[indexPath.row]
            return cell
        }
         return UITableViewCell()
    }
    func reserveSendName(btn:UIButton,reserveMode:JDhuiyuanDetail){
        print()
        if btn.titleLabel?.text! == "预付金转金额" {
            JXTAlertView.show(withTitle: "提示", message: "是否申请转预付金转金额", cancelButtonTitle: "取消", otherButtonTitle: "确定") { (_) in
                
            } otherButtonBlock: { (_) in
                NHMBProgressHud.showLoadingHudView(message: "加载中～～")
                NetManager.ShareInstance.postWith(url: "api/IPad/IPadEditBusListApply", params: ["cfdBusListGUID":reserveMode.cfdBusListGUID ?? ""]) { [self] (_) in
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
        }else{
                    let settlement = JDSettlementController()
                    settlement.cfdBusListGUID  = reserveMode.cfdBusListGUID!
                    settlement.memberModel = self.memberModel.Member;
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
        
        twoV.k_registerCell(cls: JDlasteCaozuowCell.self)
        fourV.k_registerCell(cls: JDNewcaozuoCell.self)
        
     
        
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
    
}
