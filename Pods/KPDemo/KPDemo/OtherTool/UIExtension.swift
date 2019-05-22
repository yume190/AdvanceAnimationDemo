//
//  UITableViewCellExtension.swift
//  BusApp
//
//  Created by Yume on 2016/12/28.
//  Copyright © 2016年 Yume. All rights reserved.
//

import UIKit

public protocol UIExtension: class {}
extension UIExtension where Self: UIView {
    public static var identifier: String { return String(describing: self) }
    public static var bundle: Bundle { return Bundle(for: self) }
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: bundle)
    }
}

extension UIExtension where Self: UIViewController {
    public static var identifier: String { return String(describing: self) }
    public static var bundle: Bundle { return Bundle(for: self) }
}

extension UIViewController: Reusable {}
extension UIStoryboard {
    public func instantiate<VC: UIViewController>(vc: VC.Type) -> VC? {
        return self.instantiateViewController(withIdentifier: vc.identifier) as? VC
    }
}

public protocol Reusable: UIExtension {}
extension UITableViewCell: Reusable {}
extension UICollectionReusableView: Reusable {}
extension UITableViewHeaderFooterView: Reusable {}

// MARK: 註冊
extension Reusable where Self: UITableViewCell {
    public static func registerNibTo(tableView: UITableView?, reuseIdentifier: String? = nil) {
        tableView?.register(nib, forCellReuseIdentifier: reuseIdentifier ?? identifier)
    }
    
    public static func registerClassTo(tableView: UITableView?, reuseIdentifier: String? = nil) {
        tableView?.register(self, forCellReuseIdentifier: reuseIdentifier ?? identifier)
    }
}

// MARK: 註冊
extension Reusable where Self: UICollectionViewCell {
    public static func registerNibTo(collectionView: UICollectionView?, reuseIdentifier: String? = nil) {
        collectionView?.register(nib, forCellWithReuseIdentifier: reuseIdentifier ?? identifier)
    }
    
    public static func registerClassTo(collectionView: UICollectionView?, reuseIdentifier: String? = nil) {
        collectionView?.register(self, forCellWithReuseIdentifier: reuseIdentifier ?? identifier)
    }
}

extension Reusable where Self: UITableViewHeaderFooterView {
    // MARK: 註冊
    public static func registerNibTo(tableView: UITableView?, reuseIdentifier: String? = nil) {
        tableView?.register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier ?? identifier)
    }
    
    public static func registerClassTo(tableView: UITableView?, reuseIdentifier: String? = nil) {
        tableView?.register(self, forHeaderFooterViewReuseIdentifier: reuseIdentifier ?? identifier)
    }
}

public enum UICollectionReusableViewType {
    case header // = UICollectionElementKindSectionHeader
    case footer // = UICollectionElementKindSectionFooter
    public var kind: String {
        switch self {
        case .header:
            return UICollectionView.elementKindSectionHeader
        case .footer:
            return UICollectionView.elementKindSectionFooter
        }
    }
}

extension Reusable where Self: UICollectionReusableView {
    // MARK: 註冊
    public static func registerNibTo(
        collectionView: UICollectionView?,
        type: UICollectionReusableViewType,
        reuseIdentifier: String? = nil) {
        collectionView?.register(
            nib,
            forSupplementaryViewOfKind: type.kind ,
            withReuseIdentifier: reuseIdentifier ?? identifier
        )
    }
    
    public static func registerHeaderNibTo(collectionView: UICollectionView?, reuseIdentifier: String? = nil) {
        registerNibTo(collectionView: collectionView, type: .header, reuseIdentifier: reuseIdentifier)
    }
    public static func registerFooterNibTo(collectionView: UICollectionView?, reuseIdentifier: String? = nil) {
        registerNibTo(collectionView: collectionView, type: .footer, reuseIdentifier: reuseIdentifier)
    }
    
    public static func registerClassTo(
        collectionView: UICollectionView?,
        type: UICollectionReusableViewType,
        reuseIdentifier: String? = nil) {
        
        collectionView?.register(
            self,
            forSupplementaryViewOfKind: type.kind,
            withReuseIdentifier: reuseIdentifier ?? identifier
        )
    }
    public static func registerHeaderClassTo(collectionView: UICollectionView?, reuseIdentifier: String? = nil) {
        registerClassTo(collectionView: collectionView, type: .header, reuseIdentifier: reuseIdentifier)
    }
    public static func registerFooterClassTo(collectionView: UICollectionView?, reuseIdentifier: String? = nil) {
        registerClassTo(collectionView: collectionView, type: .footer, reuseIdentifier: reuseIdentifier)
    }
}

extension UICollectionView {
    public func dequeueHeader(identifier: String, for indexPath: IndexPath) -> UICollectionReusableView {
        return self.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: identifier,
            for: indexPath
        )
    }
    
    public func dequeueFooter(identifier: String, for indexPath: IndexPath) -> UICollectionReusableView {
        return self.dequeueReusableSupplementaryView(
            ofKind: UICollectionView.elementKindSectionFooter,
            withReuseIdentifier: identifier,
            for: indexPath
        )
    }
}
