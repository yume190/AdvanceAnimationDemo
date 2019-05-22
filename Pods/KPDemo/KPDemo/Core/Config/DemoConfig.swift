//
//  DemoConfig.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/20.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public class DemoConfig {
    public typealias Cell = UITableViewCell & DemoCellShowable
    public typealias RegistableCell = UITableViewCell & DemoCellShowable & DemoCellRegistable

    private lazy var cells: [String:Cell.Type] = [:]
    
    public let isShowType: Bool
    
    public init() {
        self.isShowType = true
    }
    
    public static let `default`: DemoConfig = {
        let config = DemoConfig()
        config.register(cell: DemoBoolCell.self)
        config.register(cell: DemoUIColorCell.self)
        config.register(cell: DemoCGRectCell.self)
        config.register(cell: DemoCGSizeCell.self)
        config.register(cell: DemoCGPointCell.self)
        config.register(cell: DemoBoolCell.self)
        config.register(cell: DemoPrimtiveCell.self)
        return config
    }()
    
    public static func register(cell: RegistableCell.Type) {
        self.default.register(types: cell.registTypes, cell: cell)
    }
    
    public static func register(types: [Any.Type], cell: Cell.Type) {
        self.default.register(types: types, cell: cell)
    }
    
    private func register(cell: RegistableCell.Type) {
        self.register(types: cell.registTypes, cell: cell)
    }
    
    private func register(types: [Any.Type], cell: Cell.Type) {
        for _type in types {
            self[_type] = cell
        }
    }
    
    public static func get(_type: Any.Type) -> Cell.Type? {
        return self.default[_type]
    }
    
    subscript(_type: Any.Type) -> Cell.Type? {
        get {
            return self.cells["\(_type)"]
        }
        set {
            self.cells["\(_type)"] = newValue
        }
    }
}
