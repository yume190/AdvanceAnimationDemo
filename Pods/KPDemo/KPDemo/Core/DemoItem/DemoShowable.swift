//
//  DemoShowable.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/20.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public protocol DemoShowable: class {
    var demoDescription: String? {get}
    var cell: (UITableViewCell & DemoCellShowable).Type {get}
    var limit: Limit? {get}
    
    var isReloadWhenSet: Bool {get}
    
    var name: String? {get}
    var targetTypeName: String {get}
    var valueTypeName: String {get}
    var isWritable: Bool {get}
    
    subscript<T>(item: Demo<T>) -> Any? {
        get set
    }
}
