//
//  EWDatePickerViewController.swift
//  EWDatePicker
//
//  Created by Ethan.Wang on 2018/8/27.
//  Copyright © 2018年 Ethan. All rights reserved.
//

import UIKit

class EWDatePickerViewController: UIViewController {

    var backDate: ((String) -> Void)?
    var hours:[Int] = [8,9,10,11,12,13,14,15,16,17,18,18,19,20,21,22,23]
    var points:[String] = ["00","30"]
    var years:[Int] = []
 
    var hoursStr : String?
    var pointStr : String?
    
    ///获取当前日期
    private var currentDateCom: DateComponents = Calendar.current.dateComponents([.year, .month, .day],   from: Date())    //日期类型
    var containV:UIView = {
        let view = UIView(frame: CGRect(x: 0, y: kScreenHeight-240, width: kScreenWidth, height: 240))
        view.backgroundColor = UIColor.white
        return view
    }()
    var backgroundView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        return view
    }()
    var picker: UIPickerView!

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        drawMyView()
     
        
    }
    // MARK: - Func
    private func drawMyView() {
        self.view.backgroundColor = UIColor.clear
        self.view.insertSubview(self.backgroundView, at: 0)
        self.modalPresentationStyle = .custom//viewcontroller弹出后之前控制器页面不隐藏 .custom代表自定义
       
        for i in 1900 ... currentDateCom.year! {
            years.append(i)
        }
        
        
        let cancel = UIButton(frame: CGRect(x: 0, y: 10, width: 50, height: 50))
        let sure = UIButton(frame: CGRect(x: kScreenWidth - 100, y: 10, width: 100, height: 50))
        cancel.setTitle("取消", for: .normal)
   
        sure.setTitle("确认", for: .normal)
        cancel.setTitleColor(UIColor.lightGray, for: .normal)
        sure.setTitleColor(UIColor.blue, for: .normal)
        cancel.addTarget(self, action: #selector(self.onClickCancel), for: .touchUpInside)
        sure.addTarget(self, action: #selector(self.onClickSure), for: .touchUpInside)
        picker = UIPickerView(frame: CGRect(x: 0, y: 24, width: kScreenWidth, height: 216))
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.clear
        picker.clipsToBounds = true//如果子视图的范围超出了父视图的边界，那么超出的部分就会被裁剪掉。
        //创建日期选择器
        self.containV.addSubview(picker)
        self.containV.addSubview(cancel)
        self.containV.addSubview(sure)
    
        self.view.addSubview(self.containV)

        self.transitioningDelegate = self as UIViewControllerTransitioningDelegate//自定义转场动画
    }

    // MARK: onClick
    @objc func onClickCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func onClickSure() {
        let dateString = String(format: "%02ld-%02ld-%02ld", self.picker.selectedRow(inComponent: 0) + (self.currentDateCom.year!), self.picker.selectedRow(inComponent: 1) + 1, self.picker.selectedRow(inComponent: 2) + 1)
          
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
         
        /// 直接回调显示
        if self.backDate != nil {
            self.backDate!("\(dateString) \(hours[self.picker.selectedRow(inComponent: 3)]):\(points[self.picker.selectedRow(inComponent: 4)])")
        }
       
        

        self.dismiss(animated: true, completion: nil)
    }
    ///点击任意位置view消失
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let currentPoint = touches.first?.location(in: self.view)
        if !self.containV.frame.contains(currentPoint ?? CGPoint()) {
            self.dismiss(animated: true, completion: nil)
        }
    }

}
// MARK: - PickerViewDelegate
extension EWDatePickerViewController:UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       
            return 5
        
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return 10
        } else if component == 1 {
            return 12
        } else  if component == 2 {
            let year: Int = pickerView.selectedRow(inComponent: 0) + currentDateCom.year!
            let month: Int = pickerView.selectedRow(inComponent: 1) + 1
            let days: Int = howManyDays(inThisYear: year, withMonth: month)
            return days
        } else if component == 3 {
            return hours.count
        } else if component == 4 {
            return points.count
        }else{
            return 0
        }
    }
    private func howManyDays(inThisYear year: Int, withMonth month: Int) -> Int {
        if (month == 1) || (month == 3) || (month == 5) || (month == 7) || (month == 8) || (month == 10) || (month == 12) {
            return 31
        }
        if (month == 4) || (month == 6) || (month == 9) || (month == 11) {
            return 30
        }
        if (year % 4 == 1) || (year % 4 == 2) || (year % 4 == 3) {
            return 28
        }
        if year % 400 == 0 {
            return 29
        }
        if year % 100 == 0 {
            return 28
        }
        return 29
    }
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
            
        return kScreenWidth / 5
        
       
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == 0 {
             
                return "\((currentDateCom.year!) + row)\("年")"
           
            
         
        } else if component == 1 {
            return "\(row + 1)\("月")"
        } else if component == 2  {
            return "\(row + 1)\("日")"
        }else if component == 3  {
            hoursStr = "\(hours[row])"
            return "\(hours[row])\("时")"
        }else {
            pointStr = "\(points[row])"
            return "\(points[row])\("分")"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 1 {
            pickerView.reloadComponent(2)
        }
    }
}
// MARK: - 转场动画delegate
extension EWDatePickerViewController:UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = EWDatePickerPresentAnimated(type: .present)
        return animated
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animated = EWDatePickerPresentAnimated(type: .dismiss)
        return animated
    }
}
