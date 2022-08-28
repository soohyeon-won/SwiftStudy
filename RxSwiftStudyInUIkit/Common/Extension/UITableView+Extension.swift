//
//  UITableView+Extension.swift
//  RxSwiftStudyInUIkit
//
//  Created by won soohyeon on 2022/08/28.
//

import UIKit

extension NSObject {
    @objc class var nameOfClass: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {

    func register<T: UITableViewCell>(_ cellClass: T.Type) {
        register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func register<T: UITableViewHeaderFooterView>(_ viewClass: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.nameOfClass)
    }
}
