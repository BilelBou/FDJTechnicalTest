//
//  CollectionView+Ext.swift
//  FDJTest
//
//  Created by Bilel Bouricha on 24/11/2022.
//

import UIKit

extension UICollectionReusableView: ReusableView { }

public extension UICollectionView {

    func dequeueSupplementaryView<T: UICollectionReusableView>(of kind: String, for indexPath: IndexPath) -> T {
        let supplementaryView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: T.reuseIdentifier, for: indexPath)
        return supplementaryView as! T
    }

    func register(_ type: UICollectionReusableView.Type, forSupplementaryViewOfKind kind: String) {
        register(type,forSupplementaryViewOfKind: kind, withReuseIdentifier: type.reuseIdentifier)
    }

    func dequeue<T: UICollectionViewCell>(for indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath)
        return cell as! T
    }

    func register(_ type: UICollectionViewCell.Type) {
        register(type, forCellWithReuseIdentifier: type.reuseIdentifier)
    }
}

public protocol ReusableView {
    static var reuseIdentifier: String { get }
}

public extension ReusableView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
