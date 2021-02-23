//
//  JDReservedOrderViewController.swift
//  JDFragility
//
//  Created by nh on 2021/1/20.
//

import UIKit

class JDReservedOrderViewController: JDBaseViewController {

    
    @IBOutlet weak var ewmI: UIImageView!
 
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var yuangongNameL: UILabel!
    @IBOutlet weak var tableView: UITableView!
 
    var cfdReserveId :String?
    var deleteArr = [JDdeleteModel]()
    var cfdEmployeeArr = [MemberDetailModel]()
    
    var authoizationM :JDauthoizationModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                title="预约订单结账"
         setUI()
         setData()
        setRefreshhData()
    }
    @IBAction func closeBtn(_ sender: Any) {
        navigationController?.popViewController(animated:true)
    }
    
    @IBAction func jiezhangClick() {
        NHMBProgressHud.showLoadingHudView(message: "结帐中～～")
        let params = ["cfdReserveId":cfdReserveId ?? "" ]
        NetManager.ShareInstance.postWith(url: "api/IPad/IPadSaveTimeUseList", params: params as [String : Any]) { (dic) in
            NHMBProgressHud.showSuccesshTips(message: "结帐成功！")
            self.navigationController?.popViewController(animated:true)
            NHMBProgressHud.hideHud()
        } error: { (error) in
            NHMBProgressHud.hideHud()
            NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
        }

        
    }
    //
}

extension JDReservedOrderViewController: UITableViewDelegate,UITableViewDataSource,reveredOrderDelegate{
    func reveredOrderModel(mode: JDauthoizationDetailListModel, btn1: UIButton, btn2: UIButton, btn3: UIButton, strArr: [String]) {
        if self.cfdEmployeeArr.count == 0 {
            NHMBProgressHud.showErrorMessage(message: "暂无可选员工！")
            return
        }
  let alterV = JDalterEmployee(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: kScreenHeight))
        alterV.dataArr = self.cfdEmployeeArr
        alterV.twoselteddataArr = strArr
        Kwindow.window?.addSubview( alterV)
        alterV.cancelB.addAction { (_) in
            for item in self.cfdEmployeeArr{
                item.isSeted = false
            }
             alterV.removeFromSuperview()
        }
        alterV.sureB.addAction { (_) in
        
           
            alterV.removeFromSuperview()
            var a :String?
            var b :String?
            var c :String?
            if alterV.selteddataArr.count == 3{
                 a  = alterV.selteddataArr[0]
                b  = alterV.selteddataArr[1]
                c   = alterV.selteddataArr[2]
            }else if alterV.selteddataArr.count == 2{
                a  = alterV.selteddataArr[0]
                 b   = alterV.selteddataArr[1]
            }else{
                 a   = alterV.selteddataArr[0]
            }
            let params = ["cfdReserveDetailGUID":mode.cfdReserveDetailGUID ?? "", "cfdEmployeeIdA":a ?? "" ,"cfdEmployeeIdB":b ?? "" ,"cfdEmployeeIdC":c ?? "" ]
            NetManager.ShareInstance.postWith(url: "api/IPad/IPadEditRDEmployee", params: params as [String : Any]) { (dic) in
                self.setRefreshhData()
                for item in self.cfdEmployeeArr{
                    item.isSeted = false
                }
//                print(dic)
//                btn1.setTitle(a ?? "暂无", for: .normal)
//                btn2.setTitle(b ?? "暂无", for: .normal)
//                btn3.setTitle(c ?? "暂无", for: .normal)
            } error: { (error) in
                print(error)
            }

            
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        53
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.authoizationM?.DetailList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.k_dequeueReusableCell(cls: JDreveredOrderCell.self, indexPath: indexPath)
        cell.backgroundColor = UIColor.white
        cell.selectionStyle = .none;
        cell.authoizatioOrederModel = self.authoizationM?.DetailList[indexPath.row]
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
       
        let listmodel = self.authoizationM?.DetailList[indexPath.row]
        var name = [String]()
        for item in deleteArr {
            name.append(item.cfdName ?? "")
        }
        
        
        JSsignalert.show(withTitle: "取消原因", titles: name, selectStr: name[0]) { [self] (str) in
            for model:JDdeleteModel in  self.deleteArr{
                if str == model.cfdName{
                    NetManager.ShareInstance.postWith(url: "api/IPad/IPadEditRDCancel", params: ["cfdReserveDetailGUID":listmodel?.cfdReserveDetailGUID ?? "","ifdCancelReason":model.cfdKey ?? "" ]) { (dic) in
                        guard let arr = dic as? [[String : Any]] else { return }
                         self.cfdEmployeeArr  = arr.kj.modelArray(MemberDetailModel.self)
                         
                    } error: { (error) in
                        print(error)
                    }
                    
                    break
                }
            }
        }
        }
    
}

extension JDReservedOrderViewController{
    
    func setUI(){ 
        tableView.k_registerCell(cls: JDreveredOrderCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.tableFooterView = UIView()
    }
}

extension JDReservedOrderViewController{
    
    func setRefreshhData(){
        NHMBProgressHud.showLoadingHudView(message: "加载中～～")
        let params = ["cfdReserveId":cfdReserveId ?? "" ]
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryReserve", params: params) { (dic) in
            NHMBProgressHud.hideHud()
          guard let dics = dic as? [String : Any] else {NHMBProgressHud.showErrorMessage(message: "稍后再试");   return }
          let wemStr = dics["PayCode"] as? String
          self.ewmI.image = wemStr?.k_createQRCode()
                    
          if let Reserve = dic["Reserve"] as? [String : Any] {
              self.authoizationM =  Reserve.kj.model(JDauthoizationModel.self)
              self.yuangongNameL.text = self.authoizationM?.cfdEmployeeName ?? "暂无"
              self.timeL.text = self.authoizationM?.dfdTime_End ?? "暂无"
              self.tableView.reloadData()
          }
        } error: { (error) in

        }
        
    }
    
    func setData(){
     
        let cfdFendianId = UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""
 
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryEmployeeList", params: ["cfdFendianId":cfdFendianId ]) { (dic) in
            guard let arr = dic as? [[String : Any]] else { return }
             self.cfdEmployeeArr  = arr.kj.modelArray(MemberDetailModel.self)
            
  
//            self.alterV.k_addTarget { (_) in
//                self.alterV.isHidden = true
//            }
            
        } error: { (error) in
            print(error)
        }
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryCancelReason", params: nil) { (dic) in
         
            guard let arr = dic as? [[String : Any]] else { return }
             self.deleteArr  = arr.kj.modelArray(JDdeleteModel.self)
              
            
        } error: { (error) in
            print(error)
        }
        
}
}
