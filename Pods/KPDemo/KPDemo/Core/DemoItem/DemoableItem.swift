//
//  DemoableItem.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/20.
//  Copyright © 2019 Yume. All rights reserved.
//

import Foundation

public protocol DemoableItem {
    associatedtype Target
    associatedtype Value
    var keyPath: KeyPath<Target, Value> {get}
}
