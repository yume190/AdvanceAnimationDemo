//
//  Limit.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/22.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public struct Limit {
    public let min: CGFloat
    public let max: CGFloat
    public let step: CGFloat
    
    public init(min: CGFloat, max: CGFloat, step: CGFloat = 1) {
        self.min = min
        self.max = max
        self.step = step
    }
    
    public static var valueM1_1: Limit = Limit(min: -1, max: 1)
    
    public static var value0_1: Limit = Limit(min: 0, max: 1)
    public static var value0_50: Limit = Limit(min: 0, max: 50)
    public static var value0_300: Limit = Limit(min: 0, max: 300)
    
    public static var value1_3: Limit = Limit(min: 1, max: 3)
}
