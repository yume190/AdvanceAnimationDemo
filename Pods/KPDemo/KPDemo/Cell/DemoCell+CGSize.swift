//
//  PresentBasicTableViewCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public class DemoCGSizeCell: DemoBasicCell {
    // MARK: UI
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
    var _size: CGSize = .zero
    
    final override public func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        
        stack.arrange(views: [
            self.widthStack,
            self.heightStack,
            ])
    }
    
    final override func getting() {
        super.getting()
        
        if let value = self.getter?() as? CGSize {
            self._size = value
            
            self.widthValueLabel.text = String(format: "width: %.2f", self._size.width)
            self.heightValueLabel.text = String(format: "height: %.2f", self._size.height)
            
            self.widthValue.value = Float(self._size.width)
            self.heightValue.value = Float(self._size.height)
        }
    }
    
    public override func show<T>(showable: DemoShowable, item: Demo<T>) {
        super.show(showable: showable, item: item)
        if let limit = showable.limit {
            widthValue.maximumValue = Float(limit.max)
            heightValue.maximumValue = Float(limit.max)
            widthValue.minimumValue = Float(limit.min)
            heightValue.minimumValue = Float(limit.min)
        }
    }
}

// MARK: Actions
extension DemoCGSizeCell {
    @objc func widthing(sender: UISlider) {
        self._size.width = CGFloat(sender.value)
        self.setter?(self._size)
        self.getting()
    }
    
    @objc func heighting(sender: UISlider) {
        self._size.height = CGFloat(sender.value)
        self.setter?(self._size)
        self.getting()
    }
}

extension DemoCGSizeCell: DemoCellRegistable {
    public static var registTypes: [Any.Type] {
        return andOptional(_type: CGSize.self)
    }
}
