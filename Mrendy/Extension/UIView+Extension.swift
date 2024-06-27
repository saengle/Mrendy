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
extension UIView: ReuseIdentifying {
    static var id: String {
        return String(describing: self)
    }
}
