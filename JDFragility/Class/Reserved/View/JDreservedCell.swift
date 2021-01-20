//
//  JDreservedCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/6.
//

import UIKit

// 自定义section的headerView
// 协议，点击headerView的回调
protocol reserveSendDelegate:NSObjectProtocol {
    func reserveSendName(reserveMode:JDreserverModel)
    func ediReserveSendName(reserveMode:ResListModel)
}


class JDreservedCell: UITableViewCell {
    weak var delegate:reserveSendDelegate?
    @IBOutlet weak var reserveAddBtn: UIButton!
    @IBOutlet weak var nameL: UILabel!
    @IBOutlet weak var typeL: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        layout.itemSize = CGSize( width: 100 , height: 40)
           layout.minimumLineSpacing=10;
           
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.k_registerCell(cls: JDreserveItemCell.self)
        setUI()
        
        reserveAddBtn.addAction { (btn) in
            // 添加预约
           if ((self.delegate?.responds(to: Selector(("reserveSendName")))) != nil) {
            self.delegate?.reserveSendName(reserveMode:self.reserveMode!)
            }
        }
    }

    
    var reserveMode : JDreserverModel? {
        didSet{
            nameL.text = reserveMode?.cfdEmployeeName
            typeL.text = reserveMode?.cfdLevel
            self.collectionView.reloadData()
        }
    }
    
    
}
extension JDreservedCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        reserveMode?.ResList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.k_dequeueReusableCell(cls: JDreserveItemCell.self, indexPath: indexPath)
        cell.resListModel = reserveMode?.ResList[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 编辑预约
       if ((self.delegate?.responds(to: Selector(("ediReserveSendName")))) != nil) {
        let mode = self.reserveMode?.ResList[indexPath.row]
        
        self.delegate?.ediReserveSendName(reserveMode:mode!)
        }
    }
    func setUI() {
     
    }
}
