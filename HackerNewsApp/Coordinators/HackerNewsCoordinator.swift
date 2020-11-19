//
//  HackerNewsCoordinator.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 19/11/2020.
//

final class HackerNewsCoordinator: BaseCoordinator {
    override func start() {
        let viewController = HackerNewsViewController.instantiate()
        buildHackerNewsFlow(viewController: viewController)
        navigationController.pushViewController(viewController, animated: true)
    }
}

// MARK: - Private Methods
private extension HackerNewsCoordinator {
    func buildHackerNewsFlow(viewController: HackerNewsViewController) {
        let hackerNewsViewModel = HackerNewsViewModel(service: HackerNewsService())
        hackerNewsViewModel.delegate = self
        viewController.viewModel = hackerNewsViewModel
    }
}

// MARK: - HackerNewsDelegate
extension HackerNewsCoordinator: HackerNewsDelegate {
    func didTapHackerNew(hackerNew: HackerNew) {
        
    }
}
