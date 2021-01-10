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
    
    var reserveArr = [JDreserverModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.red
        setUI()
//        setData()
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
            self.setData()
        })
        tableView.mj_header?.beginRefreshing()
    }



}
extension JDReservedController{
    fileprivate func setData(){
        let cfdFendianId = UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""
        let params = ["cfdFendianId":cfdFendianId,"dfdDateTime":Date.init().k_toDateStr("yyyy-MM-dd")]
        
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryReserveView", params: params) { (reserve) in
            self.tableView.mj_header?.endRefreshing()
//            reserve = JDreserverModel.deserialize(from: reserve as? Dictionary)
//            let arr = JsonUtil.jsonArrayToModel(reserve.array as! String, JDreserverModel.self) as? [JDreserverModel]
            guard let arr = reserve as? [[String : Any]] else { return }
            self.reserveArr  = arr.kj.modelArray(JDreserverModel.self)
 
            self.tableView.reloadData()
        } error: { (error) in
            
        }

    }
}

extension JDReservedController{
   fileprivate func setUI() {
    allBtn.cornerRadius(radius: 20)
    daiquerenBtn.cornerRadius(radius: 20)
    querenBtn.cornerRadius(radius: 20)
    daodianBtn.cornerRadius(radius: 20)
    kaidianBtn.cornerRadius(radius: 20)
    cancelBtn.cornerRadius(radius: 20)
    chidaoBtn.cornerRadius(radius: 20)
    
    
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
    func reserveSendName() {
        let goReserved = JDGoReserveController()
        goReserved.title="添加预约"
        navigationController?.pushViewController(goReserved, animated: true)
    }
    //编辑预约
    func ediReserveSendName(){
        NHMBProgressHud.showErrorMessage(message: "编辑预约")
//        let  alertController =  UIAlertController (title:  "保存或删除数据" , message:  "删除数据将不可恢复" ,
//                                                 preferredStyle: .actionSheet)
//        let  cancelAction =  UIAlertAction (title:  "取消" , style: .cancel, handler:  nil )
//        let  sureAction =  UIAlertAction (title:  "确定" , style: .destructive, handler:  nil )
//        let  ediAction =  UIAlertAction (title:  "修改" , style: . default , handler:  nil )
////        let  shouquanAction =  UIAlertAction (title:  "授权" , style: . default , handler:  nil )
////        let  jiezhangAction =  UIAlertAction (title:  "结账" , style: . default , handler:  nil )
////        let  menberAction =  UIAlertAction (title:  "查看会员360" , style: . default , handler:  nil )
//        alertController.addAction(cancelAction)
//        alertController.addAction(sureAction)
////        alertController.addAction(shouquanAction)
////        alertController.addAction(ediAction)
////        alertController.addAction(jiezhangAction)
////        alertController.addAction(menberAction)
//        alertController.popoverPresentationController?.sourceView = self.view
//        alertController.popoverPresentationController?.sourceRect = CGRect(origin:self.view.center, size: CGSize(width:1, height: 1))
//
//        present(alertController, animated: true, completion: nil)
        
         
    }
}
