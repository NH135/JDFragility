//
//  JDsaoEWMController.swift
//  JDFragility
//
//  Created by apple on 2021/1/28.
//

import UIKit
import swiftScan

class JDsaoEWMController: LBXScanViewController {
//    https://www.jianshu.com/p/56a09cf7aba9?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       //自定义视图导航标题
        self.title = "二维码/条码"
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.tintColor = UIColor.white
        
        //扫描动画：在github下载项目，复制CodeScan.bundle获取图片
        var style = LBXScanViewStyle()
        style.anmiationStyle = .NetGrid
        style.animationImage = UIImage(named: "CodeScan.bundle/qrcode_scan_part_net")//引用bundle中的图片
        scanStyle = style
        
    }
    
    
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
           if let result = arrayResult.first {
               let msg = result.strScanned
               print("扫描结果:" + msg!)

           }
       }


    
    
    
    
    
    
}
