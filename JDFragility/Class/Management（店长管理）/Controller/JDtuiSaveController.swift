//
//  JDtuiSaveController.swift
//  JDFragility
//
//  Created by apple on 2021/2/8.
//

import UIKit

class JDtuiSaveController: JDBaseViewController , DZNEmptyDataSetSource, DZNEmptyDataSetDelegate{

    @IBOutlet weak var memberTelL: UIButton!
    @IBOutlet weak var telF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var yuanyinF: UITextView!
    @IBOutlet weak var moneyF: UITextField!
    @IBOutlet weak var typeBtn: UIButton!
    @IBOutlet weak var sureBtn: UIButton!
    
    var TimeList = [JDGroupProjectModel]()
 
    
    var memberModel = MemberDetailModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "退课"
        
        typeBtn.k_cornerRadius = 15;
        typeBtn.k_setBorder(color: UIColor.k_colorWith(hexStr: "e3e3e3"), width: 1)
        typeBtn.hw_locationAdjust(buttonMode: .Right, spacing: 10)
        yuanyinF.k_cornerRadius = 4;
        yuanyinF.k_setBorder(color: UIColor.k_colorWith(hexStr: "e3e3e3"), width: 1)
        yuanyinF.k_placeholder = "请输入退款原因"
        yuanyinF.k_placeholderColor = UIColor.lightGray;
        tableView.delegate = self
        tableView.dataSource = self
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
        tableView.k_registerCell(cls: JDtuisaveCell.self)
        
        
        sureBtn.addAction { (_) in
            let params = ["cfdMoTel": self.telF.text ?? ""]
            
         
                NetManager.ShareInstance.postWith(url: "api/IPad/IPadAddRefund", params: params) { (dic) in
                    NHMBProgressHud.hideHud()
                 
                } error: { (error) in
                    NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
                }

        }
    }

 
}
extension JDtuiSaveController:UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == telF {
//         搜索会员
            telF.resignFirstResponder()
            NHMBProgressHud.showLoadingHudView(message: "加载中‘’‘’")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                NHMBProgressHud.hideHud()
            }
            let params = ["cfdMoTel": telF.text ?? ""]
            
         
                NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryMemberCourse", params: params) { (dic) in
                    NHMBProgressHud.hideHud()
                   
                    guard let dics = dic as? [String : Any] else {
                        textField.text = ""
                        NHMBProgressHud.showSuccesshTips(message: "未查到该会员信息,请重新输入！")
                        return
                        
                    }
                    let Memberdic = dics["Member"] as? [String : Any]
                    self.memberModel =  Memberdic?.kj.model(MemberDetailModel.self) ?? MemberDetailModel()
                    self.memberTelL.setTitle("\(self.memberModel.cfdMemberName ?? "暂无")    \(self.memberModel.cfdMoTel?.securePhoneStr ?? "暂无")", for: .normal)
              
//                    self.cfdMemberId = self.memberModel.cfdMemberId
                    self.tableView.mj_header?.beginRefreshing()
                    
                    let TimeListArr = dics["TimeList"] as? [[String : Any]]
                    self.TimeList = TimeListArr?.kj.modelArray(JDGroupProjectModel.self) ?? [JDGroupProjectModel()]
                    
                } error: { (error) in
                    NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
                }

            
        }
        
        return true
    }
    
    
   func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
       UIImage(named: "zanwu")
   }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.k_dequeueReusableCell(cls: JDtuisaveCell.self, indexPath: indexPath)
        cell.backgroundColor = UIColor.lightText
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
      
      let xibView = Bundle.main.loadNibNamed("JDtuiSaveHeaderView", owner: nil, options: nil)?.first as! UIView
        xibView.backgroundColor = UIColor.k_colorWith(hexStr: "e9e9e9")
        xibView.frame = CGRect(x: 0, y: 0, width: kScreenWidth, height: 40)
      return xibView
        
    }
    
}
