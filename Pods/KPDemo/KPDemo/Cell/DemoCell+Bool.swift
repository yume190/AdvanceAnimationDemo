//
//  PresentBasicTableViewCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public class DemoBoolCell: DemoBasicCell {
    lazy var boolSwitch: UISwitch = UISwitch()
    lazy var boolValueLabel: UILabel = UILabel.custom()
    
    final override public func setup() {
        super.setup()
        self.basicValueLabel.isHidden = true
        let _stack: UIStackView = UIStackView.custom { (stack: UIStackView) in
            stack.arrange(views: [
                self.boolValueLabel,
                self.boolSwitch,
                ])
        }

        self.stack.addArrangedSubview(_stack)
        
        self.boolSwitch.addTarget(
            self,
            action: #selector(self.switching(sender:)),
            for: .valueChanged
        )
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @objc func switching(sender: UISwitch) {
        self.setter?(sender.isOn)
        self.getting()
    }
    
    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    final override func getting() {
        super.getting()
        if let value = self.getter?() as? Bool {
            self.boolValueLabel.text = "\(value)"
            self.boolSwitch.isOn = value
        }
    }
}

extension DemoBoolCell: DemoCellRegistable {
    public static var registTypes: [Any.Type] {
        return andOptional(_type: Bool.self)
    }
}
