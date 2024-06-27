//
//  Common+Extension.swift
//  Mrendy
//
//  Created by 쌩 on 6/11/24.
//

import UIKit

protocol ReuseIdentifying {
    static var id: String { get }
}

extension UIViewController: ReuseIdentifying {
    static var id: String {
        return String(describing: self)
    }
}
extension UICollectionViewCell: ReuseIdentifying {
    static var id: String {
        return String(describing: self)
    }
}
extension UITableViewCell: ReuseIdentifying {
    static var id: String {
        return String(describing: self)
    }
}
