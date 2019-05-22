//
//  ViewController.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit
import KPDemo

class Ch2VC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var targetView: UIView!
    
    lazy var demo = Demo(target: self.targetView!, config: DemoConfig.default, items: [
        DemoItem(keyPath: \UIView.layer.contents),
        
        DemoItem(keyPath: \UIView.contentMode),
        DemoItem(keyPath: \UIView.layer.contentsGravity),
        
        DemoItem(keyPath: \UIView.layer.contentsScale, demoDescription: "@1x @2x @3x", limit: .value1_3),
        
        DemoItem(keyPath: \UIView.layer.masksToBounds),
        DemoItem(keyPath: \UIView.clipsToBounds),
        
        DemoItem(keyPath: \UIView.layer.contentsRect, demoDescription: "image sprite 圖片拼接", limit: .value0_1),
        
        DemoItem(keyPath: \UIView.layer.contentsCenter, demoDescription: "android 9-patch", limit: .value0_1),
        
        ]
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the targetView.
        
//        targetView.layer.backgroundColor = UIColor.purple.cgColor
        targetView.layer.contents = UIImage(named: "smoke.png")?.cgImage

        targetView.contentMode = .scaleAspectFit
        targetView.layer.contentsGravity = CALayerContentsGravity.resizeAspectFill

        targetView.layer.contentsScale = 2 // @2x...
        
        targetView.clipsToBounds = true
        targetView.layer.masksToBounds = true

        // image sprite 圖片拼接
        targetView.layer.contentsRect = CGRect(x: 0, y: 0, width: 1, height: 1)

        // 單位座標 0~1 預設 {0,0,1,1} 9-patch
        // UIImage().resizableImageWithCapInsets(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        // Interface builder: Stretching
        targetView.layer.contentsCenter = CGRect(x: 0, y: 0, width: 1, height: 1)
        
        demo.setup(tableView: self.tableView)
    }
}
