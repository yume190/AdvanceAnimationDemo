//
//  CellShowable.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/20.
//  Copyright © 2019 Yume. All rights reserved.
//

import Foundation

public protocol DemoCellShowable: class {
    var getter: (() -> Any?)? {get}
    var setter: ((Any?) -> Void)? {get}
    
    func show<T>(showable: DemoShowable, item: Demo<T>)
}
