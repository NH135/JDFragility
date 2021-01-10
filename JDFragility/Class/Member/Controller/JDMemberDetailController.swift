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
    
    
    var detaileDic = [String :Any]()
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor=UIColor.k_colorWith(hexStr: "#f8f8f8")
        
//        let erwIimage = UIImageView(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
//        erwIimage.backgroundColor=UIColor.red
//        erwIimage.k_createQrImage(url: "2131233232", placeholder: UIImage())
//        view.addSubview(erwIimage)
        setUI()
    }


    

}

extension JDMemberDetailController{
    func setUI()  {
        iconImageV.cornerRadius(radius: 40)
        iconImageV.image=UIImage(named: "Bitmap")
        nameL.text = (String(describing: detaileDic["cfdEmployeeName"]  ?? "暂无"))
        scoureL.text = "客户来源：\(String(describing: detaileDic["cfdSource"]  ?? "暂无"))  手机号：\(String(describing: detaileDic["cfdMoTel"]  ?? "暂无"))"
        creatL.text = "注册时间：\(String(describing: detaileDic["dfdCreateDate"]  ?? "暂无"))  归属门店：\(String(describing: detaileDic["cfdFendianName"]  ?? "暂无"))  生日：\(String(describing: detaileDic["dfdBirthday"]  ?? "暂无"))"
        
    }
    
}
