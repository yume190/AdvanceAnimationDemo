//
//  PresentBasicTableViewCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public class DemoPrimtiveCell: DemoBasicCell {
    // MARK: UI
    lazy var value: UISlider = UISlider.custom { (slider) in
        slider.addTarget(self, action: #selector(self.valueing(sender:)), for: .valueChanged)
    }
    lazy var valueLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
    }
    private lazy var valueStack: UIStackView = UIStackView.custom { (stack) in
        stack.arrange(views: [
            self.valueLabel,
            self.value,
            ])
    }
    
    // MARK: Values
    var _value: NSNumber = NSNumber(value: 0)
    
    final override public func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        
        stack.arrange(views: [
            self.valueStack,
            ])
    }
    
    final override func getting() {
        super.getting()
        
        if let value = self.getter?() as? NSNumber {
            self._value = value
            
            self.valueLabel.text = String(format: "value: %.2f", self._value.floatValue)

            self.value.value = self._value.floatValue
        }
    }
    
    public override func show<T>(showable: DemoShowable, item: Demo<T>) {
        super.show(showable: showable, item: item)
        if let limit = showable.limit {
            value.maximumValue = Float(limit.max)
            value.minimumValue = Float(limit.min)
        }
    }
}

// MARK: Actions
extension DemoPrimtiveCell {
    @objc func valueing(sender: UISlider) {
        self._value = NSNumber(value: sender.value)
        self.setter?(self._value)
        self.getting()
    }
}

extension DemoPrimtiveCell: DemoCellRegistable {
    public static var registTypes: [Any.Type] {
        return [
            andOptional(_type: Int.self),
            andOptional(_type: Int8.self),
            andOptional(_type: Int16.self),
            andOptional(_type: Int32.self),
            andOptional(_type: Int64.self),
            
            andOptional(_type: Float.self),
            andOptional(_type: Float32.self),
            andOptional(_type: Float64.self),
            andOptional(_type: Double.self),
            andOptional(_type: CGFloat.self),
        ].flatMap {$0}
    }
}
