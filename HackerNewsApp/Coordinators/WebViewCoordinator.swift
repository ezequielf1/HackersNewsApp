//
//  WebViewCoordinator.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 19/11/2020.
//

final class WebViewCoordinator: BaseCoordinator {
    private let hackerNew: HackerNew
    
    init(hackerNew: HackerNew) {
        self.hackerNew = hackerNew
    }
    
    override func start() {
        let viewController: WebViewController = .loadFromNib()
        viewController.stringURL = hackerNew.storyUrl ?? ""
        navigationController.pushViewController(viewController, animated: true)
    }
}
