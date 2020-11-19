//
//  Coordinator.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 19/11/2020.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    func start()
    func start(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
}
