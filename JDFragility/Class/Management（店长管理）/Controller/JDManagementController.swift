//
//  JDManagementController.swift
//  JDFragility
//
//  Created by apple on 2020/12/30.
//（店长管理）

import UIKit

class JDManagementController: JDBaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flow: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor=UIColor.purple
        flow.itemSize = CGSize( width: 380 , height: 269)
        flow.minimumLineSpacing=30;
        flow.minimumInteritemSpacing = 30;
        flow.sectionInset = UIEdgeInsets(top: 100, left: 50, bottom: 100, right: 50);
//        flow.scrollDirection = .horizontal
        collectionView.delegate = self
        collectionView.backgroundColor=UIColor.black
        collectionView.dataSource = self
        collectionView.k_registerCell(cls: JDManageCell.self)
       
    }

 
}

extension JDManagementController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.k_dequeueReusableCell(cls: JDManageCell.self, indexPath: indexPath)
        cell.cornerRadius(radius: 8)
//        cell.titleBtn.setTitle(, for:.normal)
//        cell.titleBtn.setImage(["hy","tk","hk","pb"][indexPath.row], for: .normal)
        cell.titleBtn.k_setBtn(image: UIImage(named: ["hy","tk","gh","pb"][indexPath.row]), title: ["领卡/升卡","退课","换课","排班"][indexPath.row], titlePosition: .bottom, spacing: 20, state: .normal)
        return cell
        
    }
    
//    //每个分区的内边距
//     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
//     }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let shengCar = JDlingCarController()
        
            navigationController?.pushViewController(shengCar, animated: true)
             
        }else if indexPath.row == 1{
            let tuiKe = JDtuiKeController()
        
            navigationController?.pushViewController(tuiKe, animated: true)
        }else if indexPath.row == 2 {
            //换课
            let huanKe = JDhuanKeController()
            navigationController?.pushViewController(huanKe, animated: true)
        }else if indexPath.row == 3 {
            let paiBan = JDAttendanceController()
        
            navigationController?.pushViewController(paiBan, animated: true)
        }
    }
    
}
