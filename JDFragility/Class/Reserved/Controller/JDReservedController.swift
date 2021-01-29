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
    @IBOutlet weak var daodianBtn: UIButton!
    @IBOutlet weak var kaidianBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var chidaoBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timeView: UIView!
    @IBOutlet weak var allL: UILabel!
    @IBOutlet weak var daiL: UILabel!
    @IBOutlet weak var queL: UILabel!
    @IBOutlet weak var daoL: UILabel!
    @IBOutlet weak var kaiL: UILabel!
    @IBOutlet weak var quL: UILabel!
    @IBOutlet weak var chiL: UILabel!
    var timeStr : String?
    
    var timeBtn = UIButton()
    
    var reserveArr = [JDreserverModel]()
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
//    }
//
    
    override func viewDidLoad() {
        super.viewDidLoad()
         
        print("\(kScreenWidth)====\(view.mj_w)")
        self.timeStr = NSDate.init().string(withFormat: "yyyy-MM-dd")
        view.backgroundColor=UIColor.red
        storeNameL.text = "当前门店：\(UserDefaults.standard.string(forKey: "cfdFendianName") ?? "暂无")"
        setUI()
        tableView.tableFooterView = UIView()
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.setData()
        })
        tableView.mj_header?.beginRefreshing()
        let width = (kScreenWidth-100)/8
        
        let numbs = NSDate.latelyEightTimeCout(8)
        for (index,item) in numbs.enumerated() {
            let btn = UIButton(frame: CGRect(x: width * CGFloat(index), y: -3, width: width, height: timeView.height))
            btn.setTitle(item as? String, for: .normal)
            btn.setTitle(item as? String, for: .disabled)
            btn.tag = index
            btn.titleLabel?.numberOfLines = 2
            btn.titleLabel?.textAlignment = .center
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.setTitleColor(UIColor.k_colorWith(hexStr: "409EFF"), for: .disabled)
            if btn.tag == 0 {
                btn.isEnabled = false
                timeBtn = btn
            }
            btn.addTarget(self, action: #selector(timeBtn(btn:)),  for: .touchUpInside)
            timeView.addSubview(btn)

            
        }
        
        
//        allBtn.addAction { (_) in
//
//            let ewm = SwiftQRCodeVC()
//            ewm.backLocationString = {(c) in
//                 print(c)
//            }
//            
//            self.navigationController?.pushViewController(ewm, animated: true)
//        }
   
    }
    
    @objc func timeBtn(btn:UIButton) {
        timeBtn.isEnabled = true
        btn.isEnabled = false
        timeBtn = btn
        let time = btn.titleLabel?.text?.stringCutToEnd(star: 3)
//        setData(time:time ?? Date.init().k_toDateStr("yyyy-MM-dd"))
        self.timeStr = time;
        self.tableView.mj_header?.beginRefreshing()
        
    }

}
extension JDReservedController{
     func setData(){
        let cfdFendianId = UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""
        let params = ["cfdFendianId":cfdFendianId,"dfdDateTime":self.timeStr! ] as [String : Any]
        
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryReserveView", params: params) { (reserve) in
            self.tableView.mj_header?.endRefreshing()
 
            guard let arr = reserve as? [[String : Any]] else { return }
            self.reserveArr  = arr.kj.modelArray(JDreserverModel.self)
 
            self.tableView.reloadData()
        } error: { (error) in
            self.tableView.mj_header?.endRefreshing()
            NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
        }

    }
}

extension JDReservedController{
   fileprivate func setUI() {
    allL.cornerRadius(radius: 7)
    daiL.cornerRadius(radius: 7)
    queL.cornerRadius(radius: 7)
    daoL.cornerRadius(radius: 7)
    kaiL.cornerRadius(radius: 7)
    quL.cornerRadius(radius: 7)
    chiL.cornerRadius(radius: 7)
    
    
    tableView.delegate = self
    tableView.dataSource = self
    tableView.k_registerCell(cls: JDreservedCell.self)
    
   
    
    }
    
}

extension JDReservedController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        reserveArr.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.k_dequeueReusableCell(cls: JDreservedCell.self, indexPath: indexPath)
        cell.delegate = self
//        let group  = groups[indexPath.section] as? JDGroupModel
//        cell.textLabel?.text = "friendData!.name!"
 
        cell.reserveMode = reserveArr[indexPath.row]
        return cell
    }
    //添加预约
    func reserveSendName(reserveMode:JDreserverModel) {
        let goReserved = JDGoReserveController()
        goReserved.title="添加预约"
        goReserved.reaverdMode = reserveMode
        navigationController?.pushViewController(goReserved, animated: true)
        
    }
    //编辑预约
    func ediReserveSendName(reserveMode:ResListModel){
        var actions = [String]()
        if reserveMode.ifdState == 0 {
            actions = ["确认预约","取消预约"]
        }else if reserveMode.ifdState == 1 {
            actions = ["授权","结账","会员360","课程购买"]
        }else if reserveMode.ifdState == 2 {
            actions = ["会员360","课程购买"]
        }else if reserveMode.ifdState == 3 {
            return
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
                self.navigationController?.pushViewController(courseVC, animated: true)
            }else if cell.titleLab.text == "会员360" {
               NHMBProgressHud.showLoadingHudView(message: "加载中‘’‘’")
               DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                   NHMBProgressHud.hideHud()
               }
                let params = ["cfdMoTel": reserveMode.cfdMoTel ?? ""]
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

            }
    
        } cancelCallBack: {
            
        }.show()

    }
}
