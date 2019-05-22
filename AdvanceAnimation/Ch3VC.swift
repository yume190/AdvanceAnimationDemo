//
//  ViewController.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit
import KPDemo

class Ch3VC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    lazy var layer = CALayer()
    @IBOutlet weak var targetView: UIView!
    
    lazy var demo = Demo(target: self.layer, config: DemoConfig.default, items: [
//        DemoItem(keyPath: \UIView.center, demoDescription: "相對父圖層 anchorPoint 所在位置"),
//        DemoItem(keyPath: \UIView.layer.position, demoDescription: "相對父圖層 anchorPoint 所在位置"),
        
//        DemoItem(keyPath: \UIView.frame, demoDescription: "frame 根据bounds，position和transform(旋轉, 縮放)计算而来"),
//        DemoItem(keyPath: \UIView.bounds),
        
//        DemoItem(keyPath: \UIView.layer.anchorPoint),
        
        DemoItem(keyPath: \CALayer.frame),
        DemoItem(keyPath: \CALayer.bounds),
        DemoItem(keyPath: \CALayer.position),
        
        DemoItem(keyPath: \CALayer.transform.m11, demoDescription: "rotate x", limit: .valueM1_1),
        DemoItem(keyPath: \CALayer.transform.m22, demoDescription: "rotate y",limit: .valueM1_1),
        DemoItem(keyPath: \CALayer.transform.m33, demoDescription: "rotate z",limit: .valueM1_1),
        
        DemoItem(keyPath: \CALayer.transform.m14, demoDescription: "offset x", limit: .value0_50),
        DemoItem(keyPath: \CALayer.transform.m24, demoDescription: "offset y",limit: .value0_50),
        DemoItem(keyPath: \CALayer.transform.m34, demoDescription: "offset z",limit: .value0_50),
        
        DemoItem(keyPath: \CALayer.anchorPoint, limit: .value0_1),
        
        DemoItem(keyPath: \CALayer.backgroundColor),
        
        ]
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the targetView.
        self.targetView.layer.addSublayer(self.layer)
        self.layer.frame = self.targetView.bounds
        self.layer.backgroundColor = UIColor.red.cgColor
        
//        targetView.backgroundColor = .red
        demo.setup(tableView: self.tableView)
        

//        CGAffineTransform().a
    }
}

//self.up.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
//} else {
//    self.tableViewHeight.constant = 100
//    self.up.transform = CGAffineTransform.identity
