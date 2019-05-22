//
//  ViewController.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit
import KPDemo

class Ch4VC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var targetView: UIView!
    
    lazy var demo = Demo(target: self.targetView!, config: DemoConfig.default, items: [
        DemoItem(keyPath: \UIView.backgroundColor),
        DemoItem(keyPath: \UIView.layer.cornerRadius),
        DemoItem(keyPath: \UIView.layer.borderWidth, limit: .value0_50),
        DemoItem(keyPath: \UIView.layer.borderColor),
        
        DemoItem(keyPath: \UIView.layer.shadowOpacity, limit: .value0_1),
        DemoItem(keyPath: \UIView.layer.shadowColor),
        
        DemoItem(keyPath: \UIView.layer.shadowOffset),
        
        DemoItem(keyPath: \UIView.layer.shadowRadius),
        ]
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the targetView.
        
        targetView.backgroundColor = UIColor.red
        targetView.layer.cornerRadius = 20
        targetView.layer.borderWidth = 2
        targetView.layer.borderColor = UIColor.blue.cgColor
        
        // shadow 依照圖層內容物形狀
        
        // default: 0
        targetView.layer.shadowOpacity = 0.5
        targetView.layer.shadowColor = UIColor.green.cgColor
        
        // {0 -3} 起源 mac 座標系 y 軸相反
        targetView.layer.shadowOffset = CGSize(width: 0, height: 3)
        
        // 陰影模糊度
        targetView.layer.shadowRadius = 10
        
        demo.setup(tableView: self.tableView)
    }
}
