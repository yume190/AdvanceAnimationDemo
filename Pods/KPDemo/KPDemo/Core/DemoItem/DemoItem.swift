//
//  DemoItem.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/20.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public class DemoItem<Target, Value> {
    public let keyPath: KeyPath<Target, Value>
    public let demoDescription: String?
    public let cell: (UITableViewCell & DemoCellShowable).Type
    public var limit: Limit?
    
    public let isReloadWhenSet: Bool = true
    
    public init(
        keyPath: KeyPath<Target, Value>,
        demoDescription: String? = nil,
        cell: (UITableViewCell & DemoCellShowable).Type? = nil,
        limit: Limit? = nil) {
        self.keyPath = keyPath
        self.demoDescription = demoDescription
        self.cell = cell ?? DemoConfig.default[Value.self] ?? DemoBasicCell.self
        self.limit = limit
    }
}

extension DemoItem: DemoableItem {}
extension DemoItem: DemoShowable {
    public var name: String? {
        return self.keyPath._kvcKeyPathString
    }
    public var targetTypeName: String {
        return "\(type(of: Target.self))"
    }
    
    public var valueTypeName: String {
        return "\(type(of: Value.self))"
    }
    
    public var isWritable: Bool {
        return
            self.keyPath is ReferenceWritableKeyPath<Target, Value> ||
            self.keyPath is WritableKeyPath<Target, Value>
    }
    
    private subscript(item item: Demo<Target>) -> Value {
        get {
            return item.target[keyPath: self.keyPath]
        }
        
        set(newValue) {
            if let keyPath = self.keyPath as? ReferenceWritableKeyPath<Target, Value> {
                item.target[keyPath: keyPath] = newValue
                return
            }
            
            if let keyPath = self.keyPath as? WritableKeyPath<Target, Value> {
                item.target[keyPath: keyPath] = newValue
                return
            }
        }
    }
    
    public subscript<T>(item: Demo<T>) -> Any? {
        get {
            guard let item = item as? Demo<Target> else {
                return nil
            }
            return self[item: item]
        }
        set {
            guard let item = item as? Demo<Target> else {
                return
            }
            guard let _value = newValue, let value = _value as? Value else {
                return
            }
            
            self[item: item] = value
        }
    }
}
