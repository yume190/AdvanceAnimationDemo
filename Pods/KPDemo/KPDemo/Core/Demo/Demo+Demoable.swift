//
//  Demo.swift
//  AdvanceAnimation
//
//  Created by Yume on 2019/5/20.
//  Copyright © 2019 Yume. All rights reserved.
//

import UIKit

public class Demo<Target>: NSObject, UITableViewDelegate, UITableViewDataSource {
    public var target: Target
    public let config: DemoConfig
    public let items: [DemoShowable]
    public init(target: Target, config: DemoConfig, items: [DemoShowable]) {
        self.target = target
        self.config = config
        self.items = items
        super.init()
    }
    
    private weak var tableView: UITableView?
    public func setup(tableView: UITableView?) {
        self.tableView = tableView
        
        guard let tableView = self.tableView else {return}
        
        _ = self.items.map {
            $0.cell.registerClassTo(tableView: tableView)
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let tableView = self.tableView else {return}
        // read the CGRect from the notification (if any)
        if let newFrame = (notification.userInfo?[ UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let insets: UIEdgeInsets
            if notification.name == UIResponder.keyboardWillHideNotification {
                insets = .zero
            } else {
                insets = UIEdgeInsets( top: 0, left: 0, bottom: newFrame.height, right: 0)
            }
            
            tableView.contentInset = insets
            tableView.scrollIndicatorInsets = insets
        }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = items[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: data.cell.identifier, for: indexPath)
        let cellShowable = cell as? DemoCellShowable
        cellShowable?.show(showable: data, item: self)
        return cell
    }
    
}

extension Demo: Demoable {}
