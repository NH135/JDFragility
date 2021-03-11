//
//  JDMemberController.swift
//  JDFragility
//
//  Created by apple on 2020/12/30.
//会员信息

import UIKit
import IQKeyboardManager
class JDMemberController: JDBaseViewController, UITextFieldDelegate {
    private var currentDateCom: DateComponents = Calendar.current.dateComponents([.year, .month, .day,.hour], from: Date())
    let searchT = UITextField() 
    var sourceID :String?
    
    var cfdIntroducerT = UITextField()
    var sourceArr = [JDmemberModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
//        if isNet == true {
            
            setData()
//        }
        
    }
    
}
extension JDMemberController{
    
    
    func setData()  {

        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQuerySourceList", params: nil) { (dic) in
//
            guard let arr = dic as? [[String : Any]] else { return }
            self.sourceArr  = arr.kj.modelArray(JDmemberModel.self)
        } error: { (error) in
            NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
        }

    }
}
extension JDMemberController{
    
    func setUI() {
        
//        .text = UserDefaults.standard.string(forKey: "cfdFendianName") ?? ""
        let widthV = ( kScreenWidth-190)/2
        
        let leftView = UIView(frame: CGRect(x: 30, y: 10, width: widthV, height: kScreenHeight-60))
        leftView.k_cornerRadius = 8
        leftView.backgroundColor=UIColor.k_colorWith(hexStr: "#DC88C6");
        view.addSubview(leftView)
        
        //        let searchT = UITextField(frame: CGRect(x: 20, y: leftView.centerY, width: leftView.width-30, height: 40))
        searchT.frame = CGRect(x: 15, y: leftView.centerY, width: leftView.width-110, height: 40)
 
//        searchT.cornerRadius(radius: 20)
//        searchT.k_setBorder(color: UIColor.lightText, width: 1)
        searchT.placeholder = "请输入会员手机号";
//        searchT.text="18627912021"
        searchT.borderStyle = .roundedRect
        let imageSear = UIImageView(image: UIImage(named: "搜索-2"))
        imageSear.frame = CGRect(x: 0, y: 0, width: 50, height: 40)
        searchT.leftView = imageSear
        searchT.keyboardType = .phonePad
        searchT.delegate = self
        searchT.k_limitTextLength = 11
        searchT.returnKeyType = .search
        leftView.addSubview(searchT)
        
        
        let searchBtn = UIButton(frame: CGRect(x: searchT.rightX+10, y: searchT.y, width: 70, height: 40))
        searchBtn.setTitle("搜索", for: .normal)
        searchBtn.cornerRadius(radius: 4)
        searchBtn.backgroundColor = UIColor.k_colorWith(hexStr: "409EFF")
        leftView.addSubview(searchBtn)
        searchBtn.addAction { (_) in
            self.searchData()
        }
        
        let rightView = UIView(frame: CGRect(x: widthV+60, y: leftView.y, width: widthV, height: kScreenHeight-60))
        rightView.k_cornerRadius = 8
        rightView.backgroundColor=UIColor.k_colorWith(hexStr: "#DC88C6")
        view.addSubview(rightView)
        
        let textfH = 40
        let textfW = rightView.width-150
        let tiL = UILabel(frame: CGRect(x: 0, y: 30, width: Int(rightView.width), height: textfH))
        tiL.text = "新增会员"
        tiL.textAlignment = .center
        tiL.textColor=UIColor.white
        rightView.addSubview(tiL)
        
        
        
        
        let teL = UILabel(frame: CGRect(x: 30, y:Int(tiL.bottomY)+20, width: 100, height: textfH))
        teL.text = "手机"
        teL.textColor=UIColor.white
        rightView.addSubview(teL)
        
        let teT = UITextField(frame: CGRect(x: teL.rightX, y:teL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
        teT.placeholder = "请输入手机号"
        teT.k_limitTextLength = 11
        teT.keyboardType = .phonePad
        teT.borderStyle = .roundedRect
        teT.textColor=UIColor.black
        rightView.addSubview(teT)
        
        
        let nameL = UILabel(frame: CGRect(x: 30, y:Int(teT.bottomY)+20, width: 100, height: textfH))
        nameL.text = "姓名"
        nameL.textColor=UIColor.white
        rightView.addSubview(nameL)
        
        let nameT = UITextField(frame: CGRect(x: nameL.rightX, y:nameL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
        nameT.placeholder = "请输入姓名"
        nameT.borderStyle = .roundedRect
        nameT.textColor=UIColor.black
        rightView.addSubview(nameT)
        
        
        
        let sourceL = UILabel(frame: CGRect(x: 30, y:Int(nameL.bottomY)+20, width: 100, height: textfH))
        sourceL.text = "来源"
        sourceL.textColor=UIColor.white
        rightView.addSubview(sourceL)
        
        
        let sourceB = UIButton(frame: CGRect(x: sourceL.rightX, y:sourceL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
        sourceB.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        sourceB.setTitle("  请选择来源", for: .normal)
        sourceB.setTitleColor(UIColor.lightGray, for: .normal)
        sourceB.backgroundColor=UIColor.white
        sourceB.contentHorizontalAlignment = .left
        sourceB.cornerRadius(radius: 4)
        rightView.addSubview(sourceB)
  
        sourceB.addAction { (btn:UIButton) in
            self.view.endEditing(true)
            var couserA = [String]()
            
            for model:JDmemberModel in self.sourceArr{
 
                couserA.append(model.cfdSource!)
            }
            JSsignalert.show(withTitle: "来源", titles: couserA, selectStr: couserA[0]) { (str) in
                sourceB.setTitle("  \(String(describing: str!))" , for: .normal)
                sourceB.setTitleColor(UIColor.black, for: .normal)
                for model:JDmemberModel in self.sourceArr{
                    if str == model.cfdSource{
                        self.sourceID = model.cfdSourceId
                        break
                    }
                }
            }
        }
        
        
        let cfdIntroducerL = UILabel(frame: CGRect(x: 30, y:Int(sourceL.bottomY)+20, width: 100, height: textfH))
        cfdIntroducerL.text = "嘉宾手机号"
        
        cfdIntroducerL.textColor=UIColor.white
        rightView.addSubview(cfdIntroducerL)
        
        let cfdIntroducerT = UITextField(frame: CGRect(x: cfdIntroducerL.rightX, y:cfdIntroducerL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
        cfdIntroducerT.placeholder = "请输入嘉宾的手机号"
//        cfdIntroducerT.k_limitTextLength = 11
        cfdIntroducerT.delegate = self
        cfdIntroducerT.keyboardType = .phonePad
        cfdIntroducerT.borderStyle = .roundedRect
        cfdIntroducerT.textColor=UIColor.black
        rightView.addSubview(cfdIntroducerT)
        self.cfdIntroducerT = cfdIntroducerT
        
//        cfdIntroducerT.addTarget(self, action: #selector(textChengaes(string:)), for: .editingChanged)
        
        
        
        let sexL = UILabel(frame: CGRect(x: 30, y:Int(cfdIntroducerT.bottomY)+20, width: 100, height: textfH))
        sexL.text = "性别"
        sexL.textColor=UIColor.white
        rightView.addSubview(sexL)
    
        let sexB = UIButton(frame: CGRect(x: sexL.rightX, y:sexL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
        sexB.setTitle("  请选择性别", for: .normal)
        sexB.setTitleColor(UIColor.lightGray, for: .normal)
        sexB.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        sexB.contentHorizontalAlignment = .left
        sexB.backgroundColor=UIColor.white
        sexB.cornerRadius(radius: 4)
        
        rightView.addSubview(sexB)
        
        sexB.addAction { (btn :UIButton) in
            self.view.endEditing(true)
            let alert = UIAlertController(title:nil, message: nil, preferredStyle: .actionSheet)
                   let action = UIAlertAction(title:"男" , style: .default) { (action)in
                    sexB.setTitle("  男", for: .normal)
                    sexB.setTitleColor(UIColor.black, for: .normal)
                   }
                   let action1 = UIAlertAction(title:"女" , style: .default) { (action)in
                    sexB.setTitle("  女", for: .normal)
                    sexB.setTitleColor(UIColor.black, for: .normal)
                   }
                   alert.addAction(action)
                   alert.addAction(action1)
                
           //适配ipad需要加这两句
                   alert.popoverPresentationController?.sourceView = sexL
//            CGRect(x: sexB.centerX, y: sexB.bottomY, width: sexB.width, height:50)
            alert.popoverPresentationController?.sourceRect = sexL.bounds

            self.present(alert, animated:true, completion: nil)
        }
        
        
        
        let birthdayL = UILabel(frame: CGRect(x: 30, y:Int(sexL.bottomY)+20, width: 100, height: textfH))
        birthdayL.text = "生日"
        birthdayL.textColor=UIColor.white
        rightView.addSubview(birthdayL)
        
       
        let birthdayB = UIButton(frame: CGRect(x: birthdayL.rightX, y:birthdayL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
        birthdayB.setTitleColor(UIColor.black, for: .normal)
        birthdayB.setTitle("  请选择生日", for: .normal)
        birthdayB.setTitleColor(UIColor.lightGray, for: .normal)
        birthdayB.titleLabel?.font=UIFont.systemFont(ofSize: 16)
        birthdayB.backgroundColor=UIColor.white
        birthdayB.contentHorizontalAlignment = .left
        birthdayB.cornerRadius(radius: 4)
   
        rightView.addSubview(birthdayB)

        birthdayB.addAction { (btn:UIButton) in
            self.view.endEditing(true)
            let dataPicker = DateTimePickerView()
            dataPicker.pickerViewMode = DatePickerViewDateYearMonthDay
            dataPicker.timeStr = {(date) in
                birthdayB.setTitle("  \(date ?? "  请选择生日")", for: .normal)
                                birthdayB.setTitleColor(UIColor.black, for: .normal)
            }
            dataPicker.show()
            Kwindow.window?.addSubview(dataPicker)
        }
        
  
        
        
        
//        let weightL = UILabel(frame: CGRect(x: 30, y:Int(heightL.bottomY)+20, width: 50, height: textfH))
//        weightL.text = "体重"
//        weightL.textColor=UIColor.white
//        rightView.addSubview(weightL)
//
//        let weightT = UITextField(frame: CGRect(x: weightL.rightX, y:weightL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
//        weightT.placeholder = "请输入体重"
//        weightT.keyboardType = .phonePad
//        weightT.borderStyle = .roundedRect
//        weightT.textColor=UIColor.black
//        rightView.addSubview(weightT)
//
        
        
//        let overweightL = UILabel(frame: CGRect(x: 30, y:Int(weightL.bottomY)+20, width: 50, height: textfH))
//        overweightL.text = "超重"
//        overweightL.textColor=UIColor.white
//        rightView.addSubview(overweightL)
//
//        let overweightT = UITextField(frame: CGRect(x: overweightL.rightX, y:overweightL.y, width: CGFloat(textfW), height: CGFloat(textfH)))
//        overweightT.placeholder = "请输入超重"
//        overweightT.keyboardType = .phonePad
//        overweightT.borderStyle = .roundedRect
//        overweightT.textColor=UIColor.black
//        rightView.addSubview(overweightT)
//
        let sendBtn = UIButton(frame: CGRect(x: 40, y: birthdayL.bottomY+50, width: rightView.width-80, height: 50))
//        sendBtn.centerX = rightView.centerX
        sendBtn.setTitle("提交", for: .normal)
        sendBtn.setTitleColor(UIColor.black, for: .normal)
        sendBtn.k_cornerRadius = 25
        sendBtn.backgroundColor=UIColor.white
        rightView.addSubview(sendBtn)
        sendBtn.addAction { (btn:UIButton) in
         
            if teT.text?.length != 11{
                NHMBProgressHud.showErrorMessage(message: "请输入正确的手机号")
                return
            }else if nameT.text?.length == 0{
                NHMBProgressHud.showErrorMessage(message: "请输入姓名")
                return
            }else if self.sourceID == nil{
                NHMBProgressHud.showErrorMessage(message: "请选择来源")
                return
            }else if sexB.titleLabel?.text?.containsIgnoringCase(find: "请选择性别") ?? false {
                NHMBProgressHud.showErrorMessage(message: "请选择性别")
                return
            }else if (birthdayB.titleLabel?.text?.containsIgnoringCase(find: "请选择生日") ?? false ){
                NHMBProgressHud.showErrorMessage(message: "请选择生日")
                return
//            }else if heightT.text?.length == 0{
//                NHMBProgressHud.showErrorMessage(message: "请输入身高")
//                return
//            }else if weightT.text?.length == 0{
//                NHMBProgressHud.showErrorMessage(message: "请输入体重")
//                return
            } 
            
//            cfdIntroducer介绍人
                NHMBProgressHud.showLoadingHudView(message: "添加中···")
            let cfdFendianId = UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""
            let params = ["cfdMoTel": teT.text ?? "","cfdFendianId":cfdFendianId,"cfdMemberName":nameT.text ?? "","dfdBirthday":birthdayB.titleLabel?.text ?? "" ,"cfdSex":(sexB.titleLabel?.text == "男") ? "1"  : "0" ,"cfdSourceId":self.sourceID ?? "", "cfdIntroducer":self.cfdIntroducerT.text?.k_subText(to: 11) ?? ""] as [String : Any]
            
            NetManager.ShareInstance.postWith(url: "api/IPad/IPadAddMember", params: params) { (dic) in
                NHMBProgressHud.hideHud()
                NHMBProgressHud.showSuccesshTips(message: "添加成功")
                teT.text = ""
                nameT.text = ""
                cfdIntroducerT.text = ""
                sourceB.setTitle("  请选择来源", for: .normal)
                sourceB.setTitleColor(UIColor.lightGray, for: .normal)
                sexB.setTitle("  请选择性别", for: .normal)
                sexB.setTitleColor(UIColor.lightGray, for: .normal)
                birthdayB.setTitle("  请选择生日", for: .normal)
                birthdayB.setTitleColor(UIColor.lightGray, for: .normal)
                print(dic)
            } error: { (error) in
                NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
            }

            
        }
        
        
        
        
    }
    
}
 
extension JDMemberController{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        IQKeyboardManager.shared().isEnabled = true
      
        
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(textField == cfdIntroducerT){
            if textField.text?.length == 11 {
                textChengaes(string: textField.text ?? "")
            }
       
        }
        return true
    }
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
////        print(textField.text ?? "")
//    }
    func textChengaes(string:String){
        NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryMember", params: ["cfdMoTel": string]) { (dic) in
            NHMBProgressHud.hideHud()
            
            guard let dics = dic as? [String : Any] else {
          
                NHMBProgressHud.showSuccesshTips(message: "未查到该会员信息,请重新输入！")
                return
                
            }
            print(dics["cfdMemberName"] ?? "")
            self.cfdIntroducerT.text = "\(self.cfdIntroducerT.text ?? "")  \(dics["cfdMemberName"] ?? "")"
//                self.memberModel =  dics.kj.model(MemberDetailModel.self)
//                self.memberTelL.text = "\(self.memberModel.cfdMemberName ?? "暂无")    \(self.memberModel.cfdMoTel?.securePhoneStr ?? "暂无")"
//                self.view.endEditing(true)
//                self.iconImageV.setHeaderImageUrl(url: self.memberModel.cfdPhoto ?? "")
//                self.cfdMemberId = self.memberModel.cfdMemberId
//                //                self.tableView(self.leftTableView, didSelectRowAt: NSIndexPath(item: 0, section: 0) as IndexPath)
//                self.rightTableView.mj_header?.beginRefreshing()
        } error: { (error) in
            NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == searchT {
            searchData()
        }else if(textField == cfdIntroducerT){
            if textField.text?.length == 11 {
                textChengaes(string: textField.text ?? "")
            }
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
 
        return true
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        if textField == self.cfdIntroducerT {
//            var str = textField.text?.string
//            print(str)
//        }
//
//        return true
//    }
    
    
    func searchData(){
        //         搜索会员
                    view.endEditing(true)
                    guard searchT.text?.length == 11 else {
                        NHMBProgressHud.showErrorMessage(message: "请输入正确的手机号码")
                        return
                    }
                    NHMBProgressHud.showLoadingHudView(message: "加载中‘’‘’")
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                        NHMBProgressHud.hideHud()
                    }
        let params = ["cfdMoTel": searchT.text ?? "","cfdFendianId":UserDefaults.standard.string(forKey: "cfdFendianId") ?? ""]
                    NetManager.ShareInstance.getWith(url: "api/IPad/IPadQueryMember360", params: params) { (dic) in
                        NHMBProgressHud.hideHud()
                        guard let dics = dic as? [String : Any] else {
                            
                            return
                        }
        //                self.reserveArr  = arr.kj.modelArray(JDreserverModel.self)
                        let memberDetail = JDMemberDetailController()
                        let member =  dics.kj.model(JDmemberModel.self)
                        
                        memberDetail.memberModel =  member
                        self.searchT.text = ""
                        self.navigationController?.pushViewController(memberDetail, animated: true)
                    } error: { (error) in
                        NHMBProgressHud.hideHud()
                        NHMBProgressHud.showErrorMessage(message: (error as? String) ?? "请稍后重试")
                    }

                    
                }
}
