//
//  JDgoumaikcCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/23.
//

import UIKit

class JDgoumaikcCell: UITableViewCell {

    @IBOutlet weak var iconI: UIImageView!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var ordernumberL: UILabel!
    @IBOutlet weak var orderTableView: UITableView!
 
    
    @IBOutlet weak var weikuanPayBtn: UIButton!
    @IBOutlet weak var yufujinPayBtn: UIButton!
    @IBOutlet weak var moenyL: UILabel!
    @IBOutlet weak var orderpayCollectionView: UICollectionView!
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        orderTableView.delegate = self
        orderTableView.dataSource = self;
        orderTableView.separatorStyle = .none
        
        orderpayCollectionView.delegate = self
        orderpayCollectionView.dataSource = self
        layout.itemSize = CGSize(width: 110, height: 60)
        layout.minimumLineSpacing = 10
        orderpayCollectionView.k_registerCell(cls: JDorderPaytyoeCell.self)
        orderTableView.k_registerCell(cls: JDkechengDetaileCell.self)
        orderTableView.tableFooterView = UIView()
    }

    var goumaiModel : JDhuiyuanDetail?{
        didSet{
            yufujinPayBtn.isHidden = true
            weikuanPayBtn.isHidden = true
            if goumaiModel?.TimeList.count ?? 0 > 0 {
                orderTableView.k_cornerRadius = 6
                orderTableView.k_setBorder(color: UIColor.k_colorWith(hexStr: "EBEFF5"), width: 1)
                orderTableView.reloadData()
            }
//            if goumaiModel?.CaiWuList.count ?? 0 > 0 {
                orderpayCollectionView.reloadData()
//            }
            nameL.text = goumaiModel?.cfdFendianName ?? "暂无"
            ordernumberL.text = "\(goumaiModel?.cfdBusListGUID ?? "暂无")    \(goumaiModel?.dfdDateTime ?? "暂无")"
            if goumaiModel?.ffdArrear ?? 0 > 0 {
                
                self.moenyL.text = "订单金额:\(goumaiModel?.ffdBusMoney ?? 0)   预付金:\(goumaiModel?.ffdBusMoney ?? 0 - (goumaiModel?.ffdArrear)! )"
            }else{
                self.moenyL.text = "订单金额:\(goumaiModel?.ffdBusMoney ?? 0) "
            }
        }
    }
    
    var yufuModel : JDhuiyuanDetail?{
        didSet{
            
            yufujinPayBtn.isHidden = false
            weikuanPayBtn.isHidden = false
            if yufuModel?.TimeList.count ?? 0 > 0 {
                orderTableView.k_cornerRadius = 6
                orderTableView.k_setBorder(color: UIColor.k_colorWith(hexStr: "EBEFF5"), width: 1)
                orderTableView.reloadData()
            }
            if yufuModel?.CaiWuList.count ?? 0 > 0 {
                orderpayCollectionView.reloadData()
            }
            nameL.text = yufuModel?.cfdFendianName ?? "暂无"
            ordernumberL.text = "\(yufuModel?.cfdBusListGUID ?? "暂无")    \(yufuModel?.dfdDateTime ?? "暂无")"
            if yufuModel?.ffdArrear ?? 0 > 0 {
                
                self.moenyL.text = "订单金额:\(yufuModel?.ffdBusMoney ?? 0)   预付金:\(yufuModel?.ffdBusMoney ?? 0 - (yufuModel?.ffdArrear)! )"
            }else{
                self.moenyL.text = "订单金额:\(yufuModel?.ffdBusMoney ?? 0) "
            }
        }
    }
    
}

extension JDgoumaikcCell: UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if goumaiModel != nil {
            
        return goumaiModel?.CaiWuList.count ?? 0
        }else{
            return yufuModel?.CaiWuList.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.k_dequeueReusableCell(cls: JDorderPaytyoeCell.self, indexPath: indexPath)
        if goumaiModel != nil {
        cell.payModel = goumaiModel?.CaiWuList[indexPath.row]
        }else{
            cell.payModel = yufuModel?.CaiWuList[indexPath.row]
        }
        return cell
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if goumaiModel != nil {
            return goumaiModel?.TimeList.count ?? 0
        }else{
            return yufuModel?.TimeList.count ?? 0
        }
        
 
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.k_dequeueReusableCell(cls: JDkechengDetaileCell.self, indexPath: indexPath)
        cell.selectionStyle = .none
        if goumaiModel != nil {
        cell.kcmodel = goumaiModel?.TimeList[indexPath.row]
            
        }else{
            cell.kcmodel = yufuModel?.TimeList[indexPath.row]
        }
        return cell
    }
    
    
    
    
}