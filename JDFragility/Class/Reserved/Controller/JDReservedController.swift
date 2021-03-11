//
//  JDReservedController.swift
//  JDFragility
//
//  Created by apple on 2020/12/30.
//会员预约

import UIKit
import MJRefresh
class JDReservedController: JDBaseViewController, reserveSendDelegate {
 
    

    @IBOutlet weak var storeNameL: UILabel!
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var daiquerenBtn: UIButton!
    @IBOutlet weak var querenBtn: UIButton!
   
    @IBOutlet weak var kaidianBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
 
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var allL: UILabel!
    @IBOutlet weak var daiL: UILabel!
    @IBOutlet weak var queL: UILabel!
 
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var kaiL: UILabel!
    @IBOutlet weak var quL: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var canleLefttableView: UITableView!
    @IBOutlet weak var cancleRighttableView: UITableView!
    @IBOutlet weak var cancleBgV: UIView!
    @IBOutlet weak var cancleContenV: UIView!
    var memberModel : MemberDetailModel?
    @IBOutlet weak var cancleB: UIButton!
    
    var setedRow :Int = 0
    
    var timeStr : String?
    
    var timeBtn = UIButton()
   
    var reserveArr = [JDreserverModel]()
    var leftArr = [String]()
    var rightArr = [JDauthoizationDetailListModel]()
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//    }
//
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.setData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
         
        print("\(kScreenWidth)====\(view.mj_w)")
        self.timeStr = NSDate.init().string(withFormat: "yyyy-MM-dd")
        view.backgroundColor=UIColor.red
        storeNameL.text = "当前门店：\(UserDefaults.standard.string(forKey: "cfdFendianName") ?? "暂无")"
        setUI()
        setCancleUI()
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor.white
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.setData()
        })
        tableView.mj_header?.beginRefreshing()
//        let width = (timeView.width-100)/8
//        let timeScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: timeView.width, height: 70))
//        timeScrollView.contentSize = CGSize(width: width * 30, height: 70)
//        timeView.addSubview(timeScrollView)
//
//
//
//        let numbs = NSDate.latelyEightTimeCout(30)
//        for (index,item) in numbs.enumerated() {
//            let btn = UIButton(frame: CGRect(x: width * CGFloat(index), y: -3, width: width, height: timeView.height))
//            btn.setTitle(item as? String, for: .normal)
//            btn.setTitle(item as? String, for: .disabled)
//            btn.tag = index
//            btn.titleLabel?.numberOfLines = 2
//            btn.titleLabel?.textAlignment = .center
//            btn.setTitleColor(UIColor.black, for: .normal)
//            btn.setTitleColor(UIColor.k_colorWith(hexStr: "409EFF"), for: .disabled)
//            if btn.tag == 0 {
//                btn.isEnabled = false
//                timeBtn = btn
//            }
//            btn.addTarget(self, action: #selector(timeBtn(btn:)),  for: .touchUpInside)
//            timeScrollView.addSubview(btn)
//
//
//        }
        rightBtn.addAction { (_) in
            
        }
        
        cancleB.addAction { (_) in
            self.cancleBgV.isHidden = true
        }
    }
    
    @IBAction func cancelClick() {
        cancleBgV.isHidden = true
        
    }
    
//    @objc func timeBtn(btn:UIButton) {
//        timeBtn.isEnabled = true
//        btn.isEnabled = false
//        timeBtn = btn
//
//
//    }

}
extension JDReservedController{
     func setData(){
        let cfdFendianId = UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""
        let params = ["cfdFendianId":cfdFendianId,"dfdDateTime":self.timeStr! ] as [String : Any]
        
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryReserveView", params: params) { (reserve) in
            self.tableView.mj_header?.endRefreshing()
 
         let arr = reserve["EmpList"] as? [[String : Any]]
            self.reserveArr  = arr?.kj.modelArray(JDreserverModel.self) ?? [JDreserverModel()]
     
//            WholeNumber = 6; //全部
//            WaitNumber = 0; //待确认
//            AlreadyNumber = 3 //已确认
//            CompleteNumber = 1; //完成
//            CancelNumber = 2; //取消
//           
            
            
            self.tableView.reloadData()
            self.allL.text = "  \(reserve["WholeNumber"] as? Int ?? 0)  "
            self.daiL.text = "  \(reserve["WaitNumber"] as? Int ?? 0)  "
            self.queL.text = "  \(reserve["AlreadyNumber"] as? Int ?? 0)  "
            self.kaiL.text = "  \(reserve["CompleteNumber"] as? Int ?? 0)  "
            self.quL.text = "  \(reserve["CancelNumber"] as? Int ?? 0)  "
            
            
            
        } error: { (error) in
            self.tableView.mj_header?.endRefreshing()
            NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
        }

    }
}

extension JDReservedController{
   fileprivate func setUI() {
    allL.k_cornerRadius = 7
    daiL.k_cornerRadius = 7
    queL.k_cornerRadius = 7
    kaiL.k_cornerRadius = 7
    quL.k_cornerRadius = 7
    
    
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.k_registerCell(cls: JDreservedCell.self)
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.k_registerCell(cls: JDtimeCell.self)
    layout.itemSize = CGSize(width: 110, height: 70)
    layout.scrollDirection = .horizontal
    collectionView.showsVerticalScrollIndicator = true
//    layout.minimumLineSpacing = 10
    
    }
    
}

extension JDReservedController{
    func setCancleUI() {
        cancleContenV.cornerRadius(radius: 10)
        cancleB.cornerRadius(radius: 25)
        
        cancleRighttableView.delegate = self
        cancleRighttableView.dataSource = self
        
        canleLefttableView.delegate = self
        canleLefttableView.dataSource = self
        cancleRighttableView.tableFooterView = UIView()
        canleLefttableView.tableFooterView = UIView()
    }
}
extension JDReservedController:UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       30
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.k_dequeueReusableCell(cls: JDtimeCell.self, indexPath: indexPath)
        let numbs = NSDate.latelyEightTimeCout(30)
        cell.timeL.text = numbs[indexPath.row] as? String
        if indexPath.item == setedRow {
            cell.timeL.textColor = UIColor.k_colorWith(hexStr: "409EFF")
        }else{
            cell.timeL.textColor = UIColor.black
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        setedRow = indexPath.row
        let numbs = NSDate.latelyEightTimeCout(30)
        print(numbs[setedRow])
        collectionView.reloadData()
        
        let time = numbs[setedRow]
//        setData(time:time ?? Date.init().k_toDateStr("yyyy-MM-dd"))
        self.timeStr = (time as! String).stringCutToEnd(star: 3);
        self.tableView.mj_header?.beginRefreshing()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
           return reserveArr.count
        }else  if tableView == self.cancleRighttableView{
            return rightArr.count
        }else{
            return leftArr.count
        }
        
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
        let cell = tableView.k_dequeueReusableCell(cls: JDreservedCell.self, indexPath: indexPath)
        cell.backgroundColor = UIColor.white
        cell.delegate = self
//        let group  = groups[indexPath.section] as? JDGroupModel
//        cell.textLabel?.text = "friendData!.name!"
 
        cell.reserveMode = reserveArr[indexPath.row]
        return cell
            
            
        }else  if tableView == self.cancleRighttableView{
            var cell = tableView.dequeueReusableCell(withIdentifier: "canclerightyuyueID")
            if (cell == nil) {
                cell = UITableViewCell(style: .default, reuseIdentifier: "canclerightyuyueID")
            }
//            ResListModel
            let model = rightArr[indexPath.row]
           
            cell?.backgroundColor = UIColor.k_colorWith(hexStr: "#CCCCCC")
            cell?.textLabel?.text = model.cfdItemName
            return cell!
        }else{
            var cell = tableView.dequeueReusableCell(withIdentifier: "cancleyuyueID")
            if (cell == nil) {
                cell = UITableViewCell(style: .default, reuseIdentifier: "cancleyuyueID")
            }
            cell?.textLabel?.text = leftArr[indexPath.row]
            cell?.backgroundColor = UIColor.k_colorWith(hexStr: "#E4E4E4")
            return cell!
        }
    }
    //添加预约
    func reserveSendName(reserveMode:JDreserverModel) {
        let goReserved = JDGoReserveController()
        goReserved.title="添加预约"
        goReserved.reaverdMode = reserveMode
        navigationController?.pushViewController(goReserved, animated: true)
        
    }
    //编辑预约
    func ediReserveSendName(reserveMode: ResListModel, cfdEmployeeName: String?) {
//        if reserveMode.ifdState == 3 {
//
//            self.leftArr = ["客户手机号：\(reserveMode.cfdMoTel ?? "")","客户姓名：\(reserveMode.cfdMemberName ?? "")","预约时间：\(reserveMode.cfdTimeStar ?? "") - \(reserveMode.cfdTimeEnd ?? "")","预约员工：\(cfdEmployeeName ?? "" )","状态：取消"]
//
//            NHMBProgressHud.showLoadingHudView(message: "加载中～～")
//            let params = ["cfdReserveId":reserveMode.cfdReserveId!]
//            NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryReserve", params: params as [String : Any]) { (dic) in
//                NHMBProgressHud.hideHud()
//
////                if let dics = dic["Member"] as? [String : Any] {
////                    self.memberModel =  dics.kj.model(MemberDetailModel.self)
//////                    self.kehuNameL.text = self.memberModel?.cfdMemberName ?? "暂无"
//////                    self.kehuTelT.resignFirstResponder()
////                    self.leftArr = ["客户手机号：\(self.memberModel?.cfdMoTel ?? "")","客户姓名：\(self.memberModel?.cfdMemberName ?? "")","预约时间：\(reserveMode.cfdTimeStar ?? "") - \(reserveMode.cfdTimeEnd ?? "")","预约员工：\(self.memberModel?.cfdMemberName ?? ","状态：取消"]
////                }else{
////                    NHMBProgressHud.showErrorMessage(message: "查询暂无结果，请查证后重新输入")
////                }
////
//
//                if let dics = dic["Reserve"] as? [String : Any] {
//                guard let arr = dics["DetailList"]  as? [[String : Any]] else { return }
//                self.rightArr  = arr.kj.modelArray(JDauthoizationDetailListModel.self)
//////
//                self.cancleRighttableView.reloadData()
//                self.canleLefttableView.reloadData()
//                self.cancleBgV.isHidden = false
//
//                }
//            } error: { (error) in
//
//            }
//
//
//        }else{
        var actions = [String]()
        if reserveMode.ifdState == 0 {
            actions = ["确认预约","取消预约"]
        }else if reserveMode.ifdState == 1 {
//            actions = ["授权","结账","会员360","课程购买"]
            actions = ["授权","结账","课程购买"]
        }else if reserveMode.ifdState == 2 {
            actions = ["预约详情","课程购买"]
        }else if reserveMode.ifdState == 3 {
            actions = ["预约详情"]
        }
        if actions.count == 0 {
            return
        }
        YQActionSheet(headerTitle: nil, actionTitles: actions, configuration: nil, cellCommonConfiguration: nil) { (cell, index) in
            print("\(cell.titleLab.text ?? "")====\(index)")
            if cell.titleLab.text == "确认预约" {
           
                let params = ["ifdState":"1","cfdReserveId":reserveMode.cfdReserveId! ]
                NHMBProgressHud.showLoadingHudView(message: "确认中～～")
                NetManager.ShareInstance.postWith(url: "api/IPad/IPadEditReserveState", params: params) { (dic) in
                    NHMBProgressHud.hideHud()
                    NHMBProgressHud.showSuccesshTips(message: "确认成功")
                    self.tableView.mj_header?.beginRefreshing()
                } error: { (error) in
                    NHMBProgressHud.hideHud()
                    NHMBProgressHud.showErrorMessage(message: "确认失败，请重试")
                }

                
            }else if cell.titleLab.text == "取消预约" {
                let params = ["ifdState":"3","cfdReserveId":reserveMode.cfdReserveId! ]
                NHMBProgressHud.showLoadingHudView(message: "取消中～～")
                NetManager.ShareInstance.postWith(url: "api/IPad/IPadEditReserveState", params: params) { (dic) in
                    NHMBProgressHud.hideHud()
                    NHMBProgressHud.showSuccesshTips(message: "取消成功")
                    self.tableView.mj_header?.beginRefreshing()
                } error: { (error) in
                    NHMBProgressHud.hideHud()
                    NHMBProgressHud.showErrorMessage(message: "取消失败，请重试")
                }
            }else if cell.titleLab.text == "授权" {
                let khauthoriztionVC = JDReveredAuthorizationController()
                khauthoriztionVC.cfdReserveId = reserveMode.cfdReserveId
                self.navigationController?.pushViewController(khauthoriztionVC, animated: true)
            }else if cell.titleLab.text == "结账" {
                
                let reservedOrderVC = JDReservedOrderViewController()
                reservedOrderVC.cfdReserveId = reserveMode.cfdReserveId
                self.navigationController?.pushViewController(reservedOrderVC, animated: true)
            }else if cell.titleLab.text == "课程购买" {
                let courseVC = JDCourseController()
                courseVC.cfdMemberId = reserveMode.cfdMemberId
                courseVC.namelTelStr = reserveMode.cfdMemberName;
                courseVC.telStr = reserveMode.cfdMoTel;
                self.navigationController?.pushViewController(courseVC, animated: true)
            }else if cell.titleLab.text == "会员360" {
               NHMBProgressHud.showLoadingHudView(message: "加载中‘’‘’")
               DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                   NHMBProgressHud.hideHud()
               }
                let params = ["cfdMoTel": reserveMode.cfdMoTel ?? "","cfdFendianId":UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""]
               NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryMember360", params: params) { (dic) in
                   NHMBProgressHud.hideHud()
                   guard let dics = dic as? [String : Any] else {
                       
                       
                       
                       return
                   }
   //                self.reserveArr  = arr.kj.modelArray(JDreserverModel.self)
                   let memberDetail = JDMemberDetailController()
                   let member =  dics.kj.model(JDmemberModel.self)
                   
                   memberDetail.memberModel =  member
     
                   self.navigationController?.pushViewController(memberDetail, animated: true)
               } error: { (error) in
                   NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
               }

            }else if cell.titleLab.text == "预约详情" {
                
                self.leftArr = ["客户手机号：\(reserveMode.cfdMoTel ?? "")","客户姓名：\(reserveMode.cfdMemberName ?? "")","预约时间：\(reserveMode.cfdTimeStar ?? "") - \(reserveMode.cfdTimeEnd ?? "")","预约员工：\(cfdEmployeeName ?? "" )","状态：取消"]
                
                NHMBProgressHud.showLoadingHudView(message: "加载中～～")
                let params = ["cfdReserveId":reserveMode.cfdReserveId!]
                NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryReserve", params: params as [String : Any]) { (dic) in
                    NHMBProgressHud.hideHud()

    //                if let dics = dic["Member"] as? [String : Any] {
    //                    self.memberModel =  dics.kj.model(MemberDetailModel.self)
    ////                    self.kehuNameL.text = self.memberModel?.cfdMemberName ?? "暂无"
    ////                    self.kehuTelT.resignFirstResponder()
    //                    self.leftArr = ["客户手机号：\(self.memberModel?.cfdMoTel ?? "")","客户姓名：\(self.memberModel?.cfdMemberName ?? "")","预约时间：\(reserveMode.cfdTimeStar ?? "") - \(reserveMode.cfdTimeEnd ?? "")","预约员工：\(self.memberModel?.cfdMemberName ?? ","状态：取消"]
    //                }else{
    //                    NHMBProgressHud.showErrorMessage(message: "查询暂无结果，请查证后重新输入")
    //                }
    //
                    
                    if let dics = dic["Reserve"] as? [String : Any] {
                    guard let arr = dics["DetailList"]  as? [[String : Any]] else { return }
                    self.rightArr  = arr.kj.modelArray(JDauthoizationDetailListModel.self)
    ////
                    self.cancleRighttableView.reloadData()
                    self.canleLefttableView.reloadData()
                    self.cancleBgV.isHidden = false
                        
                    }
                } error: { (error) in
                
                }
                
            }
    
        } cancelCallBack: {
            
        }.show()
//    }
    }
}
