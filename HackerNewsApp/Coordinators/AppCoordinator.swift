//
//  AppCoordinator.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 19/11/2020.
//

final class AppCoordinator: BaseCoordinator {
    override func start() {
        let coordinator = HackerNewsCoordinator()
        coordinator.navigationController = self.navigationController
        self.start(coordinator: coordinator)
    }
}
