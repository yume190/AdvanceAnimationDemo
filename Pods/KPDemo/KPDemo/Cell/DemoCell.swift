//
//  PresentBasicTableViewCell.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/16.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public class DemoBasicCell: UITableViewCell, DemoCellShowable {
    private lazy var nameLabel: UILabel = UILabel.custom()
    private lazy var isNilSwitch: UISwitch = UISwitch()
    private lazy var _stack: UIStackView = UIStackView.custom { (stack: UIStackView) in
        stack.arrange(views: [
            self.nameLabel,
            self.isNilSwitch
        ])
    }
    
    private lazy var demoDescriptionLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
    }
    
    private lazy var typeLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
    }
    
    lazy var basicValueLabel: UILabel = UILabel.custom { (label) in
        label.font = UIFont.systemFont(ofSize: 15)
        label.numberOfLines = 0
    }
    
    lazy var stack: UIStackView = UIStackView.custom { (stack) in
        stack.axis = .vertical
        
        self.contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.topAnchor.constraint(equalTo: stack.topAnchor, constant: -8).isActive = true
        self.contentView.bottomAnchor.constraint(equalTo: stack.bottomAnchor, constant: 8).isActive = true
        self.contentView.leadingAnchor.constraint(equalTo: stack.leadingAnchor, constant: -16).isActive = true
        self.contentView.trailingAnchor.constraint(equalTo: stack.trailingAnchor, constant: 16).isActive = true
        
        stack.arrange(views: [
            self._stack,
            self.typeLabel,
            self.demoDescriptionLabel,
            self.basicValueLabel,
            ])
    }
    
    public var getter: (() -> Any?)?
    public var setter: ((Any?) -> Void)?
    
    deinit {
        self.getter = nil
        self.setter = nil
    }

    public func setup() {
        _ = self.stack
        self.isNilSwitch.addTarget(
            self,
            action: #selector(self.switchNil(sender:)),
            for: .valueChanged
        )
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override public func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc private func switchNil(sender: UISwitch) {
        if sender.isOn {
            self.setter?(nil)
        }
        self.getting()
    }
    
    func getting() {
        guard let value = self.getter?() else {return}
        self.basicValueLabel.text = "\(value)"
        
        let isOptional = Mirror(reflecting: value)
            .displayStyle == .optional
        self.isNilSwitch.isHidden = !isOptional
    }
    
    public func show<T>(showable: DemoShowable, item: Demo<T>) {
        weak var _showable = showable
        self.getter = {
            return _showable?[item]
        }
        self.setter = { [weak self] any in
            _showable?[item] = any
            if _showable?.isReloadWhenSet ?? false {
                self?.tableView?.reloadData()
            }
        }
        
        self.nameLabel.text = showable.name
        
//        self.typeLabel.isHidden = 
        self.typeLabel.text = showable.valueTypeName
        
        self.demoDescriptionLabel.text = showable.demoDescription
        self.demoDescriptionLabel.isHidden = showable.demoDescription == nil
        
        self.isNilSwitch.isHidden = true
        self.getting()
    }
}
