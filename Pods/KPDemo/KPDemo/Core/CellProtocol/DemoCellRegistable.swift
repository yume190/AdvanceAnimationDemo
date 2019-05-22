//
//  DemoCellRegistable.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/21.
//  Copyright © 2019 Yume. All rights reserved.
//

import Foundation

public protocol DemoCellRegistable: class {
    static var registTypes: [Any.Type] {get}
}
