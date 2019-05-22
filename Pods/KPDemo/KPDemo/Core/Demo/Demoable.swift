//
//  Demoable.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/20.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public protocol Demoable: AnyObject {
    associatedtype Target
    var target: Target {get}
    var config: DemoConfig {get}
    var items: [DemoShowable] {get}
}
