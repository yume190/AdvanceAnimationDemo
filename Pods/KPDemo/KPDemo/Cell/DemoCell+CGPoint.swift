//
//  PresentBasicTableViewCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public class DemoCGPointCell: DemoBasicCell {
    // MARK: UI
    lazy var xValue: UISlider = UISlider.custom { (slider) in
        slider.addTarget(self, action: #selector(self.xing(sender:)), for: .valueChanged)
    }
    lazy var xValueLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
    }
    private lazy var xStack: UIStackView = UIStackView.custom { (stack) in
        stack.arrange(views: [
            self.xValueLabel,
            self.xValue,
            ])
    }
    
    lazy var yValue: UISlider = UISlider.custom { (slider) in
        slider.addTarget(self, action: #selector(self.ying(sender:)), for: .valueChanged)
    }
    lazy var yValueLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
        //        label.xAnchor.constraint(equalToConstant: 60).isActive = true
    }
    private lazy var yStack: UIStackView = UIStackView.custom { (stack) in
        stack.arrange(views: [
            self.yValueLabel,
            self.yValue,
            ])
    }
    
    // MARK: Values
    var _point: CGPoint = .zero
    
    final override public func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        
        stack.arrange(views: [
            self.xStack,
            self.yStack,
            ])
    }
    
    final override func getting() {
        super.getting()
        
        if let value = self.getter?() as? CGPoint {
            self._point = value
            
            self.xValueLabel.text = String(format: "x: %.2f", self._point.x)
            self.yValueLabel.text = String(format: "y: %.2f", self._point.y)

            self.xValue.value = Float(self._point.x)
            self.yValue.value = Float(self._point.y)
        }
    }
    
    public override func show<T>(showable: DemoShowable, item: Demo<T>) {
        super.show(showable: showable, item: item)
        if let limit = showable.limit {
            xValue.maximumValue = Float(limit.max)
            yValue.maximumValue = Float(limit.max)
            xValue.minimumValue = Float(limit.min)
            yValue.minimumValue = Float(limit.min)
        }
    }
    
}

// MARK: Actions
extension DemoCGPointCell {
    @objc func xing(sender: UISlider) {
        self._point.x = CGFloat(sender.value)
        self.setter?(self._point)
        self.getting()
    }
    
    @objc func ying(sender: UISlider) {
        self._point.y = CGFloat(sender.value)
        self.setter?(self._point)
        self.getting()
    }
}

extension DemoCGPointCell: DemoCellRegistable {
    public static var registTypes: [Any.Type] {
        return andOptional(_type: CGPoint.self)
    }
}
