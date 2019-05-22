//
//  PresentBasicTableViewCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public class DemoUIColorCell: DemoBasicCell {
    // MARK: UI
    lazy var redStepper: UISlider = UISlider.custom { (slider) in
        slider.addTarget(self, action: #selector(self.reding(sender:)), for: .valueChanged)
    }
    lazy var redValueLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    private lazy var redStack: UIStackView = UIStackView.custom { (stack) in
        stack.arrange(views: [
            self.redValueLabel,
            self.redStepper,
            ])
    }
    
    lazy var greenStepper: UISlider = UISlider.custom { (slider) in
        slider.addTarget(self, action: #selector(self.greening(sender:)), for: .valueChanged)
    }
    lazy var greenValueLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    private lazy var greenStack: UIStackView = UIStackView.custom { (stack) in
        stack.arrange(views: [
            self.greenValueLabel,
            self.greenStepper,
            ])
    }
    
    lazy var blueStepper: UISlider = UISlider.custom { (slider) in
        slider.addTarget(self, action: #selector(self.blueing(sender:)), for: .valueChanged)
    }
    lazy var blueValueLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    private lazy var blueStack: UIStackView = UIStackView.custom { (stack) in
        stack.arrange(views: [
            self.blueValueLabel,
            self.blueStepper,
            ])
    }
    
    lazy var alphaStepper: UISlider = UISlider.custom { (slider) in
        slider.addTarget(self, action: #selector(self.alphaing(sender:)), for: .valueChanged)
    }
    lazy var alphaValueLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
        label.widthAnchor.constraint(equalToConstant: 60).isActive = true
    }
    private lazy var alphaStack: UIStackView = UIStackView.custom { (stack) in
        self.alphaStepper.maximumValue = 100
        stack.arrange(views: [
            self.alphaValueLabel,
            self.alphaStepper,
            ])
    }
    
    // MARK: Values
    var _red: CGFloat = 1
    var _green: CGFloat = 1
    var _blue: CGFloat = 1
    var _alpha: CGFloat = 1
    var _color: UIColor {
        return UIColor(red: _red/255, green: _green/255, blue: _blue/255, alpha: _alpha/100)
    }
    
    final override public func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        
        stack.arrange(views: [
            redStack,
            greenStack,
            blueStack,
            alphaStack,
        ])
    }
    
    final override func getting() {
        super.getting()
        
        if let value = self.getter?() as? UIColor {
            self.getting(ui: value)
            return
        }
        
        if let value = self.getter?() {
            let cg = value as! CGColor
            self.getting(ui: UIColor(cgColor: cg))
        }
    }
    
    final func getting(ui: UIColor) {
        ui.getRed(&_red, green: &_green, blue: &_blue, alpha: &_alpha)
        
        _red = CGFloat(Int(_red*255))
        _green = CGFloat(Int(_green*255))
        _blue = CGFloat(Int(_blue*255))
        _alpha = CGFloat(Int(_alpha*100))
        
        self.redValueLabel.text = "\(_red)"
        self.greenValueLabel.text = "\(_green)"
        self.blueValueLabel.text = "\(_blue)"
        self.alphaValueLabel.text = "\(_alpha)"
        
        self.redStepper.value = Float(_red)
        self.greenStepper.value = Float(_green)
        self.blueStepper.value = Float(_blue)
        self.alphaStepper.value = Float(_alpha)
    }
}

// MARK: Actions
extension DemoUIColorCell {
    @objc func reding(sender: UISlider) {
        self._red = CGFloat(sender.value)
        self.setter?(self._color)
        self.setter?(self._color.cgColor)
        self.getting()
    }
    
    @objc func greening(sender: UISlider) {
        self._green = CGFloat(sender.value)
        self.setter?(self._color)
        self.setter?(self._color.cgColor)
        self.getting()
    }
    
    @objc func blueing(sender: UISlider) {
        self._blue = CGFloat(sender.value)
        self.setter?(self._color)
        self.setter?(self._color.cgColor)
        self.getting()
    }
    
    @objc func alphaing(sender: UISlider) {
        self._alpha = CGFloat(sender.value)
        self.setter?(self._color)
        self.setter?(self._color.cgColor)
        self.getting()
    }
}

extension DemoUIColorCell: DemoCellRegistable {
    public static var registTypes: [Any.Type] {
        return [
            andOptional(_type: UIColor.self),
            andOptional(_type: CGColor.self),
        ].flatMap{$0}
    }
}
