//
//  JDMemberController.swift
//  JDFragility
//
//  Created by apple on 2020/12/30.
//会员信息

import UIKit

class JDMemberController: JDBaseViewController, UITextFieldDelegate {
    private var currentDateCom: DateComponents = Calendar.current.dateComponents([.year, .month, .day,.hour], from: Date())
    let searchT = UITextField()
    var isNet:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        if isNet == true {
            print("会员信息")
            setData()
        }
        
    }
    
}
extension JDMemberController{
    
    
    func setData()  {
        NHMBProgressHud.showLoadingHudView(message: "获取中···")
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQuerySourceList", params: nil) { (dic) in
            print("来源：：：\(dic)")
            NHMBProgressHud.hideHud()
        } error: { (error) in
            print(error)
        }

    }
}
extension JDMemberController{
    
    func setUI() {
        
        let widthV = ( kScreenWidth-190)/2
        
        let leftView = UIView(frame: CGRect(x: 30, y: 10, width: widthV, height: kScreenHeight-60))
        leftView.k_cornerRadius = 8
        leftView.backgroundColor=UIColor.k_colorWith(hexStr: "#DC88C6");
        view.addSubview(leftView)
        
        //        let searchT = UITextField(frame: CGRect(x: 20, y: leftView.centerY, width: leftView.width-30, height: 40))
        searchT.frame = CGRect(x: 15, y: leftView.centerY, width: leftView.width-30, height: 40)
//        searchT.cornerRadius(radius: 20)
//        searchT.k_setBorder(color: UIColor.lightText, width: 1)
        searchT.placeholder = "请输入会员手机号";
        searchT.text="18627912021"
        searchT.borderStyle = .roundedRect
        let imageSear = UIImageView(image: UIImage(named: "搜索-2"))
        imageSear.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        searchT.leftView = imageSear
        searchT.delegate = self
        searchT.k_limitTextLength = 20
        searchT.returnKeyType = .search
 
        leftView.addSubview(searchT)
        let rightView = UIView(frame: CGRect(x: widthV+60, y: leftView.y, width: widthV, height: kScreenHeight-60))
        rightView.k_cornerRadius = 8
        rightView.backgroundColor=UIColor.k_colorWith(hexStr: "#DC88C6")
        view.addSubview(rightView)
        
        let textfH = 40
        let textfW = rightView.width-100
        let tiL = UILabel(frame: CGRect(x: 0, y: 30, width: Int(rightView.width), height: textfH))
        tiL.text = "新增会员"
        tiL.textAlignment = .center
        tiL.textColor=UIColor.white
        rightView.addSubview(tiL)
        
        
        
        let teL = UILabel(frame: CGRect(x: 30, y:Int(tiL.bottomY)+20, width: 50, height: textfH))
        teL.text = "手机"
        teL.textColor=UIColor.white
        rightView.addSubview(teL)
        
        let teT = UITextField(frame: CGRect(x: teL.rightX, y:teL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
        teT.placeholder = "请输入手机号"
        
        teT.borderStyle = .roundedRect
        teT.textColor=UIColor.white
        rightView.addSubview(teT)
        
        
        let nameL = UILabel(frame: CGRect(x: 30, y:Int(teT.bottomY)+20, width: 50, height: textfH))
        nameL.text = "姓名"
        nameL.textColor=UIColor.white
        rightView.addSubview(nameL)
        
        let nameT = UITextField(frame: CGRect(x: nameL.rightX, y:nameL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
        nameT.placeholder = "请输入姓名"
        nameT.borderStyle = .roundedRect
        nameT.textColor=UIColor.white
        rightView.addSubview(nameT)
        
        
        
        let sourceL = UILabel(frame: CGRect(x: 30, y:Int(nameL.bottomY)+20, width: 50, height: textfH))
        sourceL.text = "来源"
        sourceL.textColor=UIColor.white
        rightView.addSubview(sourceL)
        
        let sourceT = UITextField(frame: CGRect(x: sourceL.rightX, y:sourceL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
        sourceT.placeholder = "请输入姓名"
        sourceT.borderStyle = .roundedRect
        sourceT.textColor=UIColor.white
        rightView.addSubview(sourceT)
        
        
        
        let sexL = UILabel(frame: CGRect(x: 30, y:Int(sourceL.bottomY)+20, width: 50, height: textfH))
        sexL.text = "性别"
        sexL.textColor=UIColor.white
        rightView.addSubview(sexL)
        
        let sexT = UITextField(frame: CGRect(x: sexL.rightX, y:sexL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
        sexT.placeholder = "请输入姓名"
        sexT.borderStyle = .roundedRect
        sexT.textColor=UIColor.white
        rightView.addSubview(sexT)
        
        
        
        let birthdayL = UILabel(frame: CGRect(x: 30, y:Int(sexL.bottomY)+20, width: 50, height: textfH))
        birthdayL.text = "生日"
        birthdayL.textColor=UIColor.white
        rightView.addSubview(birthdayL)
        
        let birthdayB = UIButton(frame: CGRect(x: birthdayL.rightX, y:birthdayL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
//        birthdayT.placeholder = "请输入姓名"
//        birthdayT.borderStyle = .roundedRect
//        birthdayT.textColor=UIColor.white
        birthdayB.setTitle("请选择生日", for: .normal)
        birthdayB.backgroundColor=UIColor.white
        birthdayB.cornerRadius(radius: 4)
        birthdayB.setTitleColor(UIColor.lightText, for: .normal)
        rightView.addSubview(birthdayB)

        birthdayB.addAction { (btn:UIButton) in
            let dataPicker = EWDatePickerViewController()
            dataPicker.isYuyue = true
            self.definesPresentationContext = true
            /// 回调显示方法
            dataPicker.backDate = {  date in
//            dataPicker.backDate = { [weak self] date in
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-dd"
                let dateString: String = dateFormatter.string(from: date)
//                self?.label.text = dateString
                
            }
            dataPicker.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            dataPicker.picker.reloadAllComponents()
            /// 弹出时日期滚动到当前日期效果
            self.present(dataPicker, animated: true) {
                dataPicker.picker.selectRow(0, inComponent: 0, animated: true)
                dataPicker.picker.selectRow((self.currentDateCom.month!) - 1, inComponent: 1, animated:   true)
                dataPicker.picker.selectRow((self.currentDateCom.day!) - 1, inComponent: 2, animated: true)
                let hours:[Int] = [10,11,12,13,14,15,16,17,18,18,19,20,21,22]
 
            }
        }
        
        
        let heightL = UILabel(frame: CGRect(x: 30, y:Int(birthdayL.bottomY)+20, width: 50, height: textfH))
        heightL.text = "身高"
        heightL.textColor=UIColor.white
        rightView.addSubview(heightL)
        
        let heightT = UITextField(frame: CGRect(x: heightL.rightX, y:heightL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
        heightT.placeholder = "体重"
        heightT.borderStyle = .roundedRect
        heightT.textColor=UIColor.white
        rightView.addSubview(heightT)
        
        
        
        let weightL = UILabel(frame: CGRect(x: 30, y:Int(heightL.bottomY)+20, width: 50, height: textfH))
        weightL.text = "体重"
        weightL.textColor=UIColor.white
        rightView.addSubview(weightL)
        
        let weightT = UITextField(frame: CGRect(x: weightL.rightX, y:weightL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
        weightT.placeholder = "请输入姓名"
        weightT.borderStyle = .roundedRect
        weightT.textColor=UIColor.white
        rightView.addSubview(weightT)
        
        
        
        let overweightL = UILabel(frame: CGRect(x: 30, y:Int(weightL.bottomY)+20, width: 50, height: textfH))
        overweightL.text = "超重"
        overweightL.textColor=UIColor.white
        rightView.addSubview(overweightL)
        
        let overweightT = UITextField(frame: CGRect(x: overweightL.rightX, y:overweightL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
        overweightT.placeholder = "请输入姓名"
        overweightT.borderStyle = .roundedRect
        overweightT.textColor=UIColor.white
        rightView.addSubview(overweightT)
        
        let sendBtn = UIButton(frame: CGRect(x: 40, y: overweightL.bottomY+50, width: rightView.width-80, height: 50))
//        sendBtn.centerX = rightView.centerX
        sendBtn.setTitle("提交", for: .normal)
        sendBtn.setTitleColor(UIColor.black, for: .normal)
        sendBtn.k_cornerRadius = 25
        sendBtn.backgroundColor=UIColor.white
        rightView.addSubview(sendBtn)
        sendBtn.addAction { (btn:UIButton) in
            print("提交")
        }
        
        
        
        
    }
    
}
extension JDMemberController{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchT {
//         搜索会员
           
            searchT.resignFirstResponder()
 
            NHMBProgressHud.showLoadingHudView(message: "加载中‘’‘’")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                NHMBProgressHud.hideHud()
            }
            let params = ["cfdMoTel": searchT.text ?? ""]
            NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryMember360", params: params) { (dic) in
                DLog(dic)
                NHMBProgressHud.hideHud()
                
                let memberDetail = JDMemberDetailController()
//                memberDetail.
  
                self.navigationController?.pushViewController(memberDetail, animated: true)
            } error: { (err) in
                DLog(err)
            }

            
        }
        
        return true
    }
    
}
