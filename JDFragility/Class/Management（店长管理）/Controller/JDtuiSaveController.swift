//
//  JDtuiSaveController.swift
//  JDFragility
//
//  Created by apple on 2021/2/8.
//

import UIKit

class JDtuiSaveController: JDBaseViewController , DZNEmptyDataSetSource, DZNEmptyDataSetDelegate, tuiKeAddDelegate{
 
    

    @IBOutlet weak var memberTelL: UIButton!
    @IBOutlet weak var telF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var yuanyinF: UITextView!
    @IBOutlet weak var moneyF: UITextField!
    @IBOutlet weak var typeBtn: UIButton!
    @IBOutlet weak var sureBtn: UIButton!
    @IBOutlet weak var searchBtn: UIButton!
    
    var TimeList = [JDGroupProjectModel]()
    var payAllArr = [payModel]()
    var tuiList = [JDGroupProjectModel]()
    var memberModel = MemberDetailModel()
    var payId : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title = "退课"
        telF.delegate = self
        
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
            
            guard self.tuiList.count != 0 else{
                NHMBProgressHud.showErrorMessage(message: "请选择退课课程")
                return
            }
            guard self.moneyF.text?.isEmpty == false else{
                NHMBProgressHud.showErrorMessage(message: "请输入退款金额")
                return
            }
            guard self.payId != nil else{
                NHMBProgressHud.showErrorMessage(message: "请选择退款方式")
                return
            }
            let cfdEmployeeId = UserDefaults.standard.string(forKey: "cfdEmployeeId") ?? ""
            let cfdFendianId = UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""
            //let params = ["cfdRefMemberTime":self.addList.kj.JSONString(),"cfdNewCourse":shopingGroups.kj.JSONString() ,"cfdCaiWustr":moneyArr.kj.JSONString() ,"cfdEmployeeId":cfdEmployeeId,"cfdMemberId":cfdMemberId,"cfdFendianId":cfdFendianId]
            
            let params = ["cfdMemberTime":self.tuiList.kj.JSONString(),"cfdEmployeeId":cfdEmployeeId,"cfdMemberId":self.memberModel.cfdMemberId!,"cfdFendianId":cfdFendianId,"dfdRefundMoney":self.moneyF.text!]
            NetManager.ShareInstance.postWith(url: "api/IPad/IPadAddRefund", params: params) { (dic) in
                    NHMBProgressHud.showSuccesshTips(message: "添加成功！")
                self.navigationController?.popViewController(animated: true)
                } error: { (error) in
                    NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
                }

        }
         
        NetManager.ShareInstance.getWith(url:"api/IPad/IPadQueryPayMode", params: nil) { (arr) in
 
            guard let payArr = arr as? [[String:Any]] else{return}
            self.payAllArr =  payArr.kj.modelArray(payModel.self)
            var yue = payModel()
            yue.cfdPayMode = "余额"
            self.payAllArr.append(yue)
 
        } error: { (error) in
            NHMBProgressHud.hideHud()
            NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
        }
        
        typeBtn.addAction { (btn) in
            var payArr = [String]()
            for mode in self.payAllArr{
                payArr.append(mode.cfdPayMode!)
            }
            
            YQActionSheet(headerTitle: nil, actionTitles: payArr, configuration: nil, cellCommonConfiguration: nil){ (cell, index) in
          
              
                if cell.titleLab.text == "余额"{
                    btn.setTitle("余额", for: .normal)
                    self.payId = 0
                }else{
                    btn.setTitle(cell.titleLab.text, for: .normal)
      
                    for pmode in self.payAllArr{
                        if pmode.cfdPayMode == cell.titleLab.text{
                            self.payId = pmode.ifdId
                        }
                    }
                    
                }
                
            }cancelCallBack: {
                
            }.show()
            
            
        }
        
        searchBtn.addAction { (_) in
            self.searchData()
        }
    }

 
}
extension JDtuiSaveController:UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == telF {
            
            searchData()
        }
        
        return true
    }
    func tuikejianCourse(type: Bool, model: JDGroupProjectModel) {
        if type == true {
         self.tuiList.append(model)
        }else{
            self.tuiList.removeAll(where: { $0.cfdCourseClassId == model.cfdCourseClassId})
        }
    }
    
   func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
       UIImage(named: "zanwu")
   }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.TimeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.k_dequeueReusableCell(cls: JDtuisaveCell.self, indexPath: indexPath)
        cell.backgroundColor = UIColor.lightText
        cell.tuiModel = self.TimeList[indexPath.row]
        cell.selectionStyle = .none
        cell.delegate = self
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
    func searchData()  {
        
        guard telF.text?.length == 11 else {
            NHMBProgressHud.showErrorMessage(message: "请输入正确的手机号")
            return
        }
    
//         搜索会员
        NHMBProgressHud.showLoadingHudView(message: "加载中‘’‘’")
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            NHMBProgressHud.hideHud()
        }
        let params = ["cfdMoTel": telF.text ?? ""]
        
     
            NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryMemberCourse", params: params) { (dic) in
                NHMBProgressHud.hideHud()
               
                guard let dics = dic as? [String : Any] else {
                    self.telF.text = ""
                    NHMBProgressHud.showSuccesshTips(message: "未查到该会员信息,请重新输入！")
                    return
                    
                }
                let Memberdic = dics["Member"] as? [String : Any]
                self.memberModel =  Memberdic?.kj.model(MemberDetailModel.self) ?? MemberDetailModel()
                self.memberTelL.setTitle("\(self.memberModel.cfdMemberName ?? "暂无")    \(self.memberModel.cfdMoTel?.securePhoneStr ?? "暂无")", for: .normal)
                self.tableView.mj_header?.beginRefreshing()
                
                let TimeListArr = dics["TimeList"] as? [[String : Any]]
                self.TimeList = TimeListArr?.kj.modelArray(JDGroupProjectModel.self) ?? [JDGroupProjectModel()]
                self.tableView.reloadData()
            } error: { (error) in
                NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
            }
    }
}
