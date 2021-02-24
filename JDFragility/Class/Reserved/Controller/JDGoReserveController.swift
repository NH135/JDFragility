//
//  JDGoReserveController.swift
//  JDFragility
//
//  Created by nh on 2021/1/9.
//去预约

import UIKit

class JDGoReserveController:JDBaseViewController {
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.setNavigationBarHidden(false, animated: true)
//    }
    private var currentDateCom: DateComponents = Calendar.current.dateComponents([.year, .month, .day,.hour], from: Date())

    @IBOutlet weak var leftTableView: UITableView!
    @IBOutlet weak var yuangongNameL: UILabel!
    @IBOutlet weak var setedDataBtn: UIButton!
    @IBOutlet weak var kehuTelT: UITextField!
    @IBOutlet weak var kehuNameL: UILabel!
    @IBOutlet weak var rightTablView: UITableView!
    @IBOutlet weak var searchBtn: UIButton!
    
    
    
    var leftArr = [ResListModel]()
    var rightArr = [ResListModel]()
    
    var reaverdMode : JDreserverModel?
    var memberModel : MemberDetailModel?
    
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
       title="预约"
        setUI()
        setData()
    }
    @IBAction func goAuthorization(_ sender: UIButton) {
        
        guard setedDataBtn.titleLabel?.text != "请选择预约日期" else {
            NHMBProgressHud.showErrorMessage(message: "请选择预约日期")
            return
        }
        
        guard self.memberModel != nil else {
            self.kehuTelT.becomeFirstResponder()
            NHMBProgressHud.showErrorMessage(message: "请输入会员手机号进行查询添加")
            return
        }
        if self.rightArr.count == 0 {
            NHMBProgressHud.showErrorMessage(message: "请添加您要预约的项目")
            
            return
        }
        let cfdEmployeeId = UserDefaults.standard.string(forKey: "cfdEmployeeId") ?? ""
        let cfdFendianId = UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""
        let params = ["cfdMemberId":self.memberModel?.cfdMemberId ?? "","cfdReserveDetail":rightArr.kj.JSONString(),"cfdEmployeeId":reaverdMode?.cfdEmployeeId ?? "","cfdCreateUser":cfdEmployeeId,"dfdTime_Star":setedDataBtn.titleLabel?.text ?? "" ,"cfdFendianId":cfdFendianId]
        NHMBProgressHud.showLoadingHudView(message: "预约中～～")
        NetManager.ShareInstance.postWith(url: "api/IPad/IPadAddReserve", params: params) { (dic) in
            NHMBProgressHud.hideHud()
            NHMBProgressHud.showSuccesshTips(message: "预约成功啦～～")
//            self.navigationController?.pushViewController(JDyuyueAuthorization_Controller(), animated: true)
            self.navigationController?.popViewController(animated: true)
        
        } error: { (error) in
            NHMBProgressHud.hideHud()
            NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
        }

    }
     
}
extension JDGoReserveController:UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetDelegate, DZNEmptyDataSetSource,leftModelDelegate,rightModelDelegate{
  
    func setData()  {
        if kehuTelT.text?.isEmpty == false {
            setSearchT()
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == leftTableView {
            return 89
        }else  {
            return 53
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == leftTableView {
            return  leftArr.count
        }else{
            return rightArr.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == leftTableView{
            let cell = tableView.k_dequeueReusableCell(cls: JDaddleftReserveCell.self, indexPath: indexPath)
            cell.selectionStyle = .none;
            cell.addReserve = leftArr[indexPath.row]
            cell.delegate = self
            return cell
        }else {
            let cell = tableView.k_dequeueReusableCell(cls: JDaddRightReserveCell.self, indexPath: indexPath)
            cell.selectionStyle = .none;
            cell.addReserve = rightArr[indexPath.row]
            cell.delegate = self
            return cell
        }
    }
    func addleftModel(mode: ResListModel) {
        self.rightArr.append(mode)
        self.rightTablView.reloadData()
        self.leftTableView.reloadData()
    }
    func addrightModel(mode: ResListModel) {
        for (index, item) in rightArr.enumerated() {
            if item.cfdMemberCardGUID == mode.cfdMemberCardGUID {
                rightArr.remove(at: index)
                break
            }
        }
        for (_, item) in leftArr.enumerated() {
            if item.cfdMemberCardGUID == mode.cfdMemberCardGUID {
                item.ifdLastNumber! += 1
                break
            }
        }
        self.rightTablView.reloadData()
        self.leftTableView.reloadData()
    }
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        UIImage(named: "zanwu")
    }
     
}
extension JDGoReserveController:UITextFieldDelegate{
    func setUI()  {
        searchBtn.cornerRadius(radius: 4)
        setedDataBtn.k_setCornerRadius(4)
        setedDataBtn.k_setBorder(color: UIColor.k_colorWith(hexStr: "EAEAEA"), width: 1)
        yuangongNameL.text = reaverdMode?.cfdEmployeeName
//        kehuTelT.text="18627912021"
        kehuTelT.k_limitTextLength = 11
        kehuTelT.delegate = self
        setedDataBtn.addAction { (birthdayB:UIButton) in
            self.view.endEditing(true)
            let dataPicker = EWDatePickerViewController()
         
            self.definesPresentationContext = true
            /// 回调显示方法
            dataPicker.backDate = {  date in
                birthdayB.setTitle("  \(date)", for: .normal)
                birthdayB.setTitleColor(UIColor.black, for: .normal)
            }
            dataPicker.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            dataPicker.picker.reloadAllComponents()
            /// 弹出时日期滚动到当前日期效果
            self.present(dataPicker, animated: true) {
                dataPicker.picker.selectRow(0, inComponent: 0, animated: true)
                dataPicker.picker.selectRow((self.currentDateCom.month!) - 1, inComponent: 1, animated:   true)
                dataPicker.picker.selectRow((self.currentDateCom.day!) - 1, inComponent: 2, animated: true)
                let hours:[Int] = [8,9,10,11,12,13,14,15,16,17,18,18,19,20,21,22,23]
                let index = hours.firstIndex(of: NSDate.init().hour)
                let minute = NSDate.init().minute
                let type = minute > 30
            
                
                dataPicker.picker.selectRow(type == true ? (index ?? 0) + 1 : index ?? 0, inComponent: 3, animated: true)
                
                dataPicker.picker.selectRow(type == true ? 0 : 1, inComponent: 4, animated: true)
            }
        }
        
        leftTableView.delegate = self;
        leftTableView.dataSource = self;
        leftTableView.emptyDataSetSource = self;
        leftTableView.emptyDataSetDelegate = self
        leftTableView.tableFooterView=UIView()
        leftTableView.contentInset=UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        leftTableView.k_registerCell(cls: JDaddleftReserveCell.classForCoder())
        rightTablView.delegate = self;
        rightTablView.dataSource = self;
        rightTablView.contentInset=UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        rightTablView.tableFooterView=UIView()
        rightTablView.k_registerCell(cls: JDaddRightReserveCell.classForCoder())
        searchBtn.addAction { (_) in
            self.setSearchT()
        }
         
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == kehuTelT {
//         搜索会员
       
            view.endEditing(true)
            setSearchT()
        }
        return true
    }
    
    func setSearchT() {
        
        if kehuTelT.text?.length != 11 {
            NHMBProgressHud.showErrorMessage(message: "请输入正确的手机号")
           return
        }
        NHMBProgressHud.showLoadingHudView(message: "加载中～～")
        let params = ["cfdMoTel":kehuTelT.text ?? "" ]
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQRMember", params: params) { (dic) in
            NHMBProgressHud.hideHud()
            if let dics = dic["Member"] as? [String : Any] {
                self.memberModel =  dics.kj.model(MemberDetailModel.self)
                self.kehuNameL.text = self.memberModel?.cfdMemberName ?? "暂无"
                self.kehuTelT.resignFirstResponder()
            }else{
                NHMBProgressHud.showErrorMessage(message: "查询暂无结果，请查证后重新输入")
            }
             
            guard let arr = dic["TimeList"]  as? [[String : Any]] else { return }
            self.leftArr  = arr.kj.modelArray(ResListModel.self)

            self.leftTableView.reloadData()
            
        } error: { (error) in
        
        }
    }
    
    
}
