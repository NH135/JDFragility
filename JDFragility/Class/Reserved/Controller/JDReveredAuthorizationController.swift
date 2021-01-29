//
//  JDReveredAuthorizationController.swift
//  JDFragility
//
//  Created by apple on 2021/1/20.
//

import UIKit

class JDReveredAuthorizationController: JDBaseViewController {

    @IBOutlet weak var ewmI: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var yiBtn: UIButton!
    @IBOutlet weak var timeL: UILabel!
    @IBOutlet weak var yuangongNameL: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var cfdReserveId :String?
    var authoizationM :JDauthoizationModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        title="客户授权"
         setUI()
        
        
        yiBtn.addAction { (_) in
            self.setData()
        }
         setData()
    }
    @IBAction func closeBtn(_ sender: Any) {
        
        navigationController?.popViewController(animated:true)
    }
    
 
}

extension JDReveredAuthorizationController{
    func setData()  {
              NHMBProgressHud.showLoadingHudView(message: "加载中～～")
              let params = ["cfdReserveId":cfdReserveId ?? "" ]
              NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryReserve", params: params) { (dic) in
                  NHMBProgressHud.hideHud()
                guard let dics = dic as? [String : Any] else {NHMBProgressHud.showErrorMessage(message: "稍后再试");   return }
                let wemStr = dics["AuthCode"] as? String
                self.ewmI.image = wemStr?.k_createQRCode()
                          
                if let Reserve = dic["Reserve"] as? [String : Any] {
                    self.authoizationM =  Reserve.kj.model(JDauthoizationModel.self)
                    self.yuangongNameL.text = self.authoizationM?.cfdEmployeeName ?? "暂无"
                    self.nameL.text = self.authoizationM?.cfdMemberName ?? "暂无"
                    self.timeL.text = self.authoizationM?.dfdTime_End ?? "暂无"
                    self.tableView.reloadData()
                }
              } error: { (error) in

              }
    }
  
  func setUI()  {
    yiBtn.cornerRadius(radius: 6)
    tableView.k_registerCell(cls: JDkhAuthorizationCell.self)
    tableView.delegate = self
    tableView.dataSource = self
    tableView.tableFooterView = UIView()
  }
    
}
extension JDReveredAuthorizationController:UITableViewDelegate,UITableViewDataSource,khAuthorizatioDelegate{
    func khAuthorizatio(mode: JDauthoizationDetailListModel, passwordL: UILabel) {
        
        let ewm = SwiftQRCodeVC()
        ewm.modalPresentationStyle = .fullScreen
        ewm.backLocationString = {(c) in
             print(c)
                    let params = ["cfdEquFendianCode":c ,"cfdReserveDetailGUID":mode.cfdReserveDetailGUID ?? ""]
                    NHMBProgressHud.showLoadingHudView(message: "获取中～～")
                    NetManager.ShareInstance.postWith(url: "api/IPad/IPadQueryScanCodePwd", params: params) { (dic) in
                        NHMBProgressHud.hideHud()
                        NHMBProgressHud.showErrorMessage(message: "获取成功！")
                        self.setData()
                    } error: { (error) in
                        NHMBProgressHud.hideHud()
                        NHMBProgressHud.showErrorMessage(message: error as? String)
                    }

        }
        
        self.navigationController?.pushViewController(ewm, animated: false)
//        self.present(ewm, animated: true, completion: nil)
        

        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        53
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.authoizationM?.DetailList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.k_dequeueReusableCell(cls: JDkhAuthorizationCell.self, indexPath: indexPath)
        cell.selectionStyle = .none;
        cell.authoizatiodetailnModel = self.authoizationM?.DetailList[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    
  
}
