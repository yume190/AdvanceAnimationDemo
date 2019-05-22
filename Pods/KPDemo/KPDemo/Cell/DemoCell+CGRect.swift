//
//  PresentBasicTableViewCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public class DemoCGRectCell: DemoBasicCell {
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
    }
    private lazy var yStack: UIStackView = UIStackView.custom { (stack) in
        stack.arrange(views: [
            self.yValueLabel,
            self.yValue,
            ])
    }
    
    lazy var widthValue: UISlider = UISlider.custom { (slider) in
        slider.addTarget(self, action: #selector(self.widthing(sender:)), for: .valueChanged)
    }
    lazy var widthValueLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
    }
    private lazy var widthStack: UIStackView = UIStackView.custom { (stack) in
        stack.arrange(views: [
            self.widthValueLabel,
            self.widthValue,
            ])
    }
    
    lazy var heightValue: UISlider = UISlider.custom { (slider) in
        slider.addTarget(self, action: #selector(self.heighting(sender:)), for: .valueChanged)
    }
    lazy var heightValueLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
    }
    private lazy var heightStack: UIStackView = UIStackView.custom { (stack) in
        stack.arrange(views: [
            self.heightValueLabel,
            self.heightValue,
            ])
    }
    
    // MARK: Values
    var _rect: CGRect = .zero
    
    final override public func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        
        stack.arrange(views: [
            self.xStack,
            self.yStack,
            self.widthStack,
            self.heightStack,
            ])
    }
    
    final override func getting() {
        super.getting()
        
        if let value = self.getter?() as? CGRect {
            self._rect = value
            
            self.xValueLabel.text = String(format: "x: %.2f", self._rect.origin.x)
            self.yValueLabel.text = String(format: "y: %.2f", self._rect.origin.y)
            self.widthValueLabel.text = String(format: "width: %.2f", self._rect.size.width)
            self.heightValueLabel.text = String(format: "height: %.2f", self._rect.size.height)
            
            self.xValue.value = Float(self._rect.origin.x)
            self.yValue.value = Float(self._rect.origin.y)
            self.widthValue.value = Float(self._rect.size.width)
            self.heightValue.value = Float(self._rect.size.height)
        }
    }
    
    public override func show<T>(showable: DemoShowable, item: Demo<T>) {
        super.show(showable: showable, item: item)
        if let limit = showable.limit {
            xValue.maximumValue = Float(limit.max)
            yValue.maximumValue = Float(limit.max)
            xValue.minimumValue = Float(limit.min)
            yValue.minimumValue = Float(limit.min)
            
            widthValue.maximumValue = Float(limit.max)
            heightValue.maximumValue = Float(limit.max)
            widthValue.minimumValue = Float(limit.min)
            heightValue.minimumValue = Float(limit.min)
        }
    }
    
}

// MARK: Actions
extension DemoCGRectCell {
    @objc func xing(sender: UISlider) {
        self._rect.origin.x = CGFloat(sender.value)
        self.setter?(self._rect)
        self.getting()
    }
    
    @objc func ying(sender: UISlider) {
        self._rect.origin.y = CGFloat(sender.value)
        self.setter?(self._rect)
        self.getting()
    }
    
    @objc func widthing(sender: UISlider) {
        self._rect.size.width = CGFloat(sender.value)
        self.setter?(self._rect)
        self.getting()
    }
    
    @objc func heighting(sender: UISlider) {
        self._rect.size.height = CGFloat(sender.value)
        self.setter?(self._rect)
        self.getting()
    }
}

extension DemoCGRectCell: DemoCellRegistable {
    public static var registTypes: [Any.Type] {
        return andOptional(_type: CGRect.self)
    }
}
