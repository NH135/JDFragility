//
//  JDalterEmployee.swift
//  JDFragility
//
//  Created by apple on 2021/1/21.
//

import UIKit

class JDalterEmployee: UIView {

    
    var dataArr = [MemberDetailModel]()
 
    var selteddataArr = [String]()
    var tableView = UITableView()
    var sureB = UIButton()
    var cancelB = UIButton()
    var twoselteddataArr = [String]()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
        twoselteddataArr.removeAll()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension JDalterEmployee:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")

        if cell == nil {
            cell=UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.selectionStyle = .none
        let mode : MemberDetailModel = dataArr[indexPath.row]
        
        cell?.textLabel?.text = mode.cfdEmployeeName
        if mode.isSeted == true {
            cell?.accessoryType = .checkmark
        }
        for item in twoselteddataArr {
            if item == mode.cfdEmployeeName {
                cell?.accessoryType = .checkmark
                mode.isSeted = true
            }
        }
           return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
     
        let cell = tableView.cellForRow(at: indexPath)
        let mode = dataArr[indexPath.row]
        if mode.isSeted == true {
            mode.isSeted = false
            cell?.accessoryType = .none
            
            for (index,item) in selteddataArr.enumerated() {
                if item == mode.cfdEmployeeId {
                    selteddataArr.remove(at: index)
                }
            }
        }else{
            if selteddataArr.count == 3 {
                
                NHMBProgressHud.showErrorMessage(message: "最多添加三个")
                return
            }
            
            mode.isSeted = true
            cell?.accessoryType = .checkmark
            selteddataArr.append(mode.cfdEmployeeId ?? "")
        }
    }
    
    func setUI()  {
        self.backgroundColor=UIColor.black.withAlphaComponent(0.3)
        let contenV = UIView(frame: CGRect(x: 10, y: 0, width: 350, height: 400))
        contenV.k_center = self.k_center
        contenV.backgroundColor=UIColor.white
        contenV.cornerRadius(radius: 8)
        self.addSubview(contenV)
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: contenV.width, height: 40))
        title.text = "请选择"
        title.textAlignment = .center
        contenV.addSubview(title)
        
       cancelB = UIButton(frame: CGRect(x: 0, y: contenV.height-50, width: contenV.width/2, height: 50))
        cancelB.setTitle("取消", for: .normal)
        cancelB.setTitleColor(UIColor.red, for: .normal)
        contenV.addSubview(cancelB)
//        cancelB.addAction { (_) in
//            self.removeFromSuperview()
//        }
//
        sureB = UIButton(frame: CGRect(x: contenV.width/2, y: contenV.height-50, width: contenV.width/2, height: 50))
        sureB.setTitle("确认", for: .normal)
        sureB.setTitleColor(UIColor.k_colorWith(hexStr: "409EFF"), for: .normal)
        contenV.addSubview(sureB)
//        sureB.addAction { (_) in
//            print(self.selteddataArr)
//            self.removeFromSuperview()
//        }
//
        tableView = UITableView(frame: CGRect(x: 0, y: 30, width: contenV.width, height: contenV.height-90))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        contenV.addSubview(tableView)
        let lineV = UIView(frame: CGRect(x: 0, y: contenV.height-51, width: contenV.width, height: 1))
        lineV.backgroundColor=UIColor.k_colorWith(hexStr: "e1e1e1")
        contenV.addSubview(lineV)
        
     
    }
   
  
}
 
