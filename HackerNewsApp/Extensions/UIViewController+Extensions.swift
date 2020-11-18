//
//  UIViewController+Extensions.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

import UIKit

extension UIViewController {
    class func loadFromNib<T: UIViewController>() -> T {
         return T(nibName: String(describing: self), bundle: nil)
    }
}
