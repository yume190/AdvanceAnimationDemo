//
//  Stack+Ex.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/20.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

extension UIStackView {
    func arrange(views: [UIView]) {
        _ = views.map {self.addArrangedSubview($0)}
    }
    
    static func custom(setting: ((UIStackView) -> Void)? = nil) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .fill
        setting?(stack)
        return stack
    }
}

extension UILabel {
    static func custom(setting: ((UILabel) -> Void)? = nil) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = .black
        setting?(label)
        return label
    }
}

extension UIStepper {
    static func custom(setting: ((UIStepper) -> Void)? = nil) -> UIStepper {
        let stepper = UIStepper()
        stepper.maximumValue = 255
        stepper.minimumValue = 0
        stepper.stepValue = 1
        setting?(stepper)
        return stepper
    }
}

extension UISlider {
    static func custom(setting: ((UISlider) -> Void)? = nil) -> UISlider {
        let slider = UISlider()
        slider.maximumValue = 255
        slider.minimumValue = 0
        setting?(slider)
        return slider
    }
}

extension UITextField {
    static func custom(setting: ((UITextField) -> Void)? = nil) -> UITextField {
        let textField = UITextField()
        textField.keyboardType = .numbersAndPunctuation
        textField.returnKeyType = .done
        textField.delegate = ft
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        setting?(textField)
        return textField
    }
}

private var ft = FieldTemp()
private class FieldTemp: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


//https://stackoverflow.com/questions/27989094/how-to-unwrap-an-optional-value-from-any-type
func unwrap(any: Any) -> Any {
    let mi = Mirror(reflecting: any)
    if mi.displayStyle != .optional {
        return any
    }
    
    return mi.children.first?.value ?? NSNull()
}


// https://stackoverflow.com/questions/15711645/how-to-get-uitableview-from-uitableviewcell
extension UIView {
    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = self.superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        return self.parentView(of: UITableView.self)
    }
}


func andOptional<T>(_type: T.Type) -> [Any.Type] {
    return [T.self, Optional<T>.self]
}
