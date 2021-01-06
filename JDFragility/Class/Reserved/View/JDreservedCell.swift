//
//  JDreservedCell.swift
//  JDFragility
//
//  Created by apple on 2021/1/6.
//

import UIKit

class JDreservedCell: UITableViewCell {
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
    }

    var reserveMode : JDreserverModel? {
        didSet{
            nameL.text = reserveMode?.cfdEmployeeName
            typeL.text = reserveMode?.cfdLevel
        }
    }
    
    
}
extension JDreservedCell:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.k_dequeueReusableCell(cls: JDreserveItemCell.self, indexPath: indexPath)
        
        return cell
    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath)->CGSize{
//        return CGSize(width: 100, height: 40)
//    }
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int)->UIEdgeInsets{
//        return UIEdgeInsets(top: 30, left: 10, bottom: 0, right: 0)
//    }
//
//
    
    func setUI() {
     
    }
}
