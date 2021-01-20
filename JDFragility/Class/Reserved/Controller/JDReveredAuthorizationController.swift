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
         setData()
    }

 
}

extension JDReveredAuthorizationController{
    func setData()  {

            
              NHMBProgressHud.showLoadingHudView(message: "加载中～～")
              let params = ["cfdReserveId":cfdReserveId ?? "" ]
              NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryReserve", params: params) { (dic) in
                  NHMBProgressHud.hideHud()
                print(dic)
//                  if let dics = dic["Member"] as? [String : Any] {
//                      self.memberModel =  dics.kj.model(MemberDetailModel.self)
//                      self.kehuNameL.text = self.memberModel?.cfdMemberName ?? "暂无"
//                  }else{
//                      NHMBProgressHud.showErrorMessage(message: "查询暂无结果，请查证后重新输入")
//                  }
//
//                  guard let arr = dic["TimeList"]  as? [[String : Any]] else { return }
//                  self.leftArr  = arr.kj.modelArray(ResListModel.self)
//
//                  self.leftTableView.reloadData()
                
                guard let dics = dic as? [String : Any] else {NHMBProgressHud.showErrorMessage(message: "稍后再试");   return }
                
                           
                                   
                                    let wemStr = dics["AuthCode"] as? String
                                    
                self.ewmI.image = wemStr?.k_createQRCode()
                          
                if let Reserve = dic["Reserve"] as? [String : Any] {
                    self.authoizationM =  Reserve.kj.model(JDauthoizationModel.self)
                    self.yuangongNameL.text = self.authoizationM?.cfdMemberName ?? "暂无"
                    self.nameL.text = self.authoizationM?.cfdMemberName ?? "暂无"
                    self.timeL.text = self.authoizationM?.dfdTime_End ?? "暂无"
                }
                

              } error: { (error) in

              }

    }
  
  func setUI()  {
    tableView.k_registerCell(cls: JDkhAuthorizationCell.self)
    tableView.delegate = self
    tableView.dataSource = self
  }
    
}
extension JDReveredAuthorizationController:UITableViewDelegate,UITableViewDataSource,khAuthorizatioDelegate{
    func khAuthorizatio(mode: ResListModel, passwordL: UILabel) {
        passwordL.text = "123"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.k_dequeueReusableCell(cls: JDkhAuthorizationCell.self, indexPath: indexPath)
        cell.selectionStyle = .none;
//        cell.addReserve = leftArr[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    
  
}
