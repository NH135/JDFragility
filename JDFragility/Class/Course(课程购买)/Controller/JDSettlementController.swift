//
//  JDSettlementController.swift
//  JDFragility
//
//  Created by nh on 2021/1/12.
//

import UIKit

class JDSettlementController: JDBaseViewController,UITableViewDelegate,UITableViewDataSource {
 
    @IBOutlet weak var iconImagV: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var telL: UILabel!
    @IBOutlet weak var lastML: UILabel!
    @IBOutlet weak var mdL: UILabel!
    @IBOutlet weak var ewmL: UIImageView!
    @IBOutlet weak var fuML: UILabel!
    @IBOutlet weak var wanB: UIButton!
    @IBOutlet weak var yuB: UIButton!
    @IBOutlet weak var yhjB: UIButton!
    @IBOutlet weak var yhjL: UILabel!
    
      var memberModel : MemberDetailModel?
    
    @IBOutlet weak var payView: UIView!
    @IBOutlet weak var rightTableView: UITableView!
    @IBOutlet weak var shifuML: UILabel!
    @IBOutlet weak var sureB: UIButton!
    @IBOutlet weak var wxT: UITextField!
    @IBOutlet weak var ylT: UIButton!
    @IBOutlet weak var zfbT: UITextField!
    @IBOutlet weak var yeT: UIButton!
    
    @IBOutlet weak var coseB: UIButton!
    @IBOutlet weak var yhjTableView: UITableView!
    @IBOutlet weak var contenView: UIView!
    
    @IBOutlet weak var contenL: UILabel!
    var cfdBusListGUID : String?
    
    var jiesuanModel : JDjiesuanModel?
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor=UIColor.k_colorWith(hexStr: "f8f8f8")
        
        
        setletfUI()
        setrightUI()
        setcontenUI()
        setData()
    }

    
    
    
    
 
}

extension JDSettlementController{
    func setData()  {
        NetManager.ShareInstance.getWith(url:"api/IPad/IPadQueryPayMode", params: nil) { (arr) in
            print("支付方式：\(arr)")
            guard let payArr = arr as? [[String:Any]] else{return}
            let payList =  payArr.kj.modelArray(payModel.self)
//            self.addPayType
            self.addPayType(list: payList)
        } error: { (error) in
            
        }

      
        let params = ["cfdBusListGUID":cfdBusListGUID ?? "" ]
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryBusListBySave", params: params as [String : Any]) { (dic) in
            print(dic)
            guard let dict = dic as? [String : Any] else{
                return
            }
            self.jiesuanModel = dict.kj.model(JDjiesuanModel.self)

            self.ewmL.image = self.jiesuanModel?.CodeMsg.cfdCodeMsgId?.k_createQRCode()
            self.fuML.text = "应付：\(self.jiesuanModel?.BusList.ffdBusMoney ?? "0")"

            self.rightTableView.reloadData()
        } error: { (error) in
            print(error)
        }

    }
    func addPayType(list:[payModel]) {
        let width = 400
        let height = 50
        for (index ,item) in list.enumerated() {
            let vv = UIView(frame: CGRect(x:20 + index % 2 * width, y: index / 2 * (height+10), width: width, height: height))
             payView.addSubview(vv)
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
            btn.setTitle(item.cfdPayMode, for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.isUserInteractionEnabled = false
            vv.addSubview(btn)
            
            let payType = UITextField(frame: CGRect(x: 150, y: 0, width: 250, height: 50))
            payType.placeholder = "请输入\(item.cfdPayMode ?? "")金额"
            payType.borderStyle = .roundedRect
            vv.addSubview(payType)
            
            
            
            
        }
    
    }
    
}

extension JDSettlementController{
    func setletfUI()  {
        
        nameL.text = memberModel?.cfdMemberName
        telL.text = memberModel?.cfdMoTel
        lastML.text = "当前余额：\(memberModel?.ffdBalance ?? "0")"
     
        let cfdFendianName = UserDefaults.standard.string(forKey: "cfdFendianName") ?? ""
        mdL.text = "购买门店：\(cfdFendianName)"
        
        wanB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.yuB.isEnabled = true
        }
        
        yuB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.wanB.isEnabled = true
        }
    }
    
}

extension JDSettlementController{
    func setrightUI()  {
        rightTableView.tableFooterView = UIView()
        rightTableView.delegate = self
        rightTableView.dataSource = self
       rightTableView.k_registerCell(cls: JDCourseshopingCell.self)
        
//        确定付款
        
        
        sureB.addAction { (_) in
            var moneyArr = [payModel]()
            var pmodel = payModel()
            pmodel.cfdPayModeId = "c01497b2-ccc6-4e46-b0b7-57c552197606";
            pmodel.ffdIncome = "1000"
            moneyArr.append(pmodel)
            
            let params = ["cfdBusListGUID":self.cfdBusListGUID ?? "","ffdMemberBalance":"1000","cfdTokeStr":"","ifdType":"true","cfdCaiWustr":moneyArr.kj.JSONString() ]
//            ffdMemberBalance 支付金额。 cfdTokeStr 优惠卷 ifdType true完整 false预付
            NetManager.ShareInstance.postWith(url: "api/IPad/IPadPayBusList", params: params) { (dic) in
                print(dic)
            } error: { (error) in
                print(error)
            }

        }
    }
    
}


extension JDSettlementController{

    func setcontenUI()  {
        contenL.cornerRadius(corners: [.topLeft ,.topRight], radius: 10)
        contenView.backgroundColor=UIColor.black.withAlphaComponent(0.3)
        coseB.addAction { (_) in
            self.contenView.isHidden = true
        }
        contenView.k_addTarget { (_) in
            self.contenView.isHidden = true
         
        }
    }
    
}


extension JDSettlementController{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
         if tableView == rightTableView {
            return 110
        }else{
            return 90
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == yhjTableView {
         return 20
        }else if tableView == rightTableView {
            return self.jiesuanModel?.MCList.count ?? 0
        }else{
            return 0}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == yhjTableView {
            
            
        }else if tableView == rightTableView {
            let cell = tableView.k_dequeueReusableCell(cls: JDCourseshopingCell.self, indexPath: indexPath)
            cell.jiesuanModel = self.jiesuanModel?.MCList[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    

}
