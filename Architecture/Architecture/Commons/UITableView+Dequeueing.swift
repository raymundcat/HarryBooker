//
//  UITableView+Dequeueing.swift
//  Architecture
//
//  Created by Raymund Catahay on 2021-01-23.
//

import UIKit

public extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let identifier = NSStringFromClass(T.self)
        if let reusableCell = dequeueReusableCell(withIdentifier: identifier),
            let castedCell = reusableCell as? T {
            return castedCell
        } else {
            register(T.self, forCellReuseIdentifier: identifier)
            guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T else {
                fatalError("Unable to Dequeue Reusable Table View Cell")
            }
            return cell
        }
    }

    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T {
        let identifier = NSStringFromClass(T.self)
        if let reusableCell = dequeueReusableHeaderFooterView(withIdentifier: identifier),
            let castedCell = reusableCell as? T {
            return castedCell
        } else {
            register(T.self, forHeaderFooterViewReuseIdentifier: identifier)
            guard let cell = dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T else {
                fatalError("Unable to Dequeue Reusable Table View Cell")
            }
            return cell
        }
    }
}
