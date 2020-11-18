//
//  UITableView+Extensions.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

import UIKit

extension UITableView {
    // MARK: - Register
    func registerNib<T>(forType type: T.Type) where T: UITableViewCell {
        let identifier = String(describing: type)
        let nib = UINib(nibName: identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: identifier)
    }
    
    func dequeueReusableCell<T>(forType type: T.Type, atIndexPath indexPath: IndexPath) -> T? where T: UITableViewCell {
        let identifier = String(describing: type)
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T
    }
}
