//
//  JDMemberDetailController.swift
//  JDFragility
//
//  Created by apple on 2021/1/8.
//

import UIKit

class JDMemberDetailController: JDBaseViewController {
    @IBOutlet weak var iconImageV: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var scoureL: UILabel!
    @IBOutlet weak var creatL: UILabel!
    
    @IBOutlet weak var kedanB: UIButton!
    @IBOutlet weak var xiaofeiB: UIButton!
    @IBOutlet weak var cishuBtn: UIButton!
    @IBOutlet weak var chongzhiB: UIButton!
    @IBOutlet weak var chapingB: UIButton!
    @IBOutlet weak var dianpingB: UIButton!
    @IBOutlet weak var jiangeB: UIButton!
    
    @IBOutlet weak var oneV: UIView!
    
    @IBOutlet weak var twoV: UIView!
    @IBOutlet weak var threeV: UIView!
    @IBOutlet weak var fourV: UIView!
    @IBOutlet weak var oneB: UIButton!
    @IBOutlet weak var twoB: UIButton!
    @IBOutlet weak var threeB: UIButton!
    @IBOutlet weak var fourB: UIButton!
    var memberModel = JDmemberModel()
    override func viewDidLoad() {
        super.viewDidLoad()
                    title="会员360"
        view.backgroundColor=UIColor.k_colorWith(hexStr: "#f8f8f8")
        
//        let erwIimage = UIImageView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
//        erwIimage.backgroundColor=UIColor.red
//        erwIimage.k_createQrImage(url: "2131233232", placeholder: UIImage())
//        view.addSubview(erwIimage)
        kedanB.titleLabel?.numberOfLines=2
        kedanB.titleLabel?.textAlignment = .center
        xiaofeiB.titleLabel?.numberOfLines=2
        cishuBtn.titleLabel?.numberOfLines=2
        chongzhiB.titleLabel?.numberOfLines=2
        chapingB.titleLabel?.numberOfLines=2
        dianpingB.titleLabel?.numberOfLines=2
        jiangeB.titleLabel?.numberOfLines=2
        
        
        jiangeB.titleLabel?.textAlignment = .center
        dianpingB.titleLabel?.textAlignment = .center
        chapingB.titleLabel?.textAlignment = .center
        chongzhiB.titleLabel?.textAlignment = .center
        cishuBtn.titleLabel?.textAlignment = .center
        xiaofeiB.titleLabel?.textAlignment = .center
         
        setUI()
        typeView(with: 1)
    }


    

}

extension JDMemberDetailController{
    func setUI()  {
        iconImageV.cornerRadius(radius: 40)
        iconImageV.image=UIImage(named: "Bitmap")
//        detaileDic["Member"]["cfdMemberName"]
//        let MemberDic = detaileDic["Member"] as! String.Type<String : Any>
//        BadNumber = 5;差评
//        Consume = 10000消费
//        CycleNumber = 100;间隔
//        UnitPrice = 100; 客单
//        MonthsNumber = 50;次数
//        Recharge = 500;充值
//        CommentNumber = 10点评
        nameL.text = memberModel.Member.cfdMemberName
//            (String(describing: MemberDic["cfdMemberName"]  ?? "暂无"))
        scoureL.text = "客户来源:\(memberModel.Member.cfdSource ?? "")   手机号:\( memberModel.Member.cfdMoTel ?? "")"
        creatL.text = "注册时间:\(memberModel.Member.dfdCreateDate ?? "暂无")   归属门店:\( memberModel.Member.cfdFendianName ?? "")   生日:\( memberModel.Member.dfdBirthday ?? "")"
        
    
        kedanB.setTitle("\(memberModel.UnitPrice ?? "") \n 客单近三个月", for: .normal)
        xiaofeiB.setTitle("\(memberModel.MonthsNumber ?? "") \n 次数近三个月", for: .normal)
        cishuBtn.setTitle("\(memberModel.Consume ?? "") \n 消费近三个月", for: .normal)
        chongzhiB.setTitle("\(memberModel.Recharge ?? "") \n 充值近三个月", for: .normal)
        chapingB.setTitle("\(memberModel.BadNumber ?? "") \n 差评所有", for: .normal)
        dianpingB.setTitle("\(memberModel.CommentNumber ?? "") \n 点评差评所有", for: .normal)
        jiangeB.setTitle("\(memberModel.CycleNumber ?? "") \n 间隔平均", for: .normal)
        
        
        
            oneB.addAction { (btn:UIButton) in
                btn.isEnabled=false
                self.twoB.isEnabled = true
                self.threeB.isEnabled = true
                self.fourB.isEnabled = true
                self.typeView(with: 1)
            }
        twoB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.oneB.isEnabled = true
            self.threeB.isEnabled = true
            self.fourB.isEnabled = true
            self.typeView(with: 2)
        }
        threeB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.twoB.isEnabled = true
            self.oneB.isEnabled = true
            self.fourB.isEnabled = true
            self.typeView(with: 3)
        }
        fourB.addAction { (btn:UIButton) in
            btn.isEnabled=false
            self.twoB.isEnabled = true
            self.threeB.isEnabled = true
            self.oneB.isEnabled = true
            self.typeView(with: 4)
        }
        
    }
    

    
    

    
    func typeView(with type:NSInteger) {
        
        self.oneV.isHidden=true;
        self.twoV.isHidden=true;
        self.threeV.isHidden=true;
        self.fourV.isHidden=true;
       
        switch type {
        case 1:
          
            self.oneV.isHidden=false;
            self.oneV.backgroundColor=UIColor.randomColor()
        case 2:
            self.twoV.isHidden=false;
            self.twoV.backgroundColor=UIColor.randomColor()
          
        case 3:
            self.threeV.isHidden=false;
            self.threeV.backgroundColor=UIColor.randomColor()
      
        default:
            
            self.fourV.isHidden=false;
            self.fourV.backgroundColor=UIColor.randomColor()
        }
    }

}
