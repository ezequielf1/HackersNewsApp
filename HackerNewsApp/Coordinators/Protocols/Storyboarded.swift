//
//  Storyboarded.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 19/11/2020.
//

import UIKit

protocol Storyboarded {
    static func instantiate(storyBoardName: String) -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate(storyBoardName: String = "Main") -> Self {
        let fullName = NSStringFromClass(self)
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
