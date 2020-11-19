//
//  HackerNewsViewModel.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

final class HackerNewsViewModel {
    // MARK: - Public Properties
    let hackerNews: Dynamic<[HackerNew]> = Dynamic([])
    let error: Dynamic<NetworkError?> = Dynamic(nil)
    
    // MARK: - Private Properties
    private let service: HackerNewsService
    
    init(service: HackerNewsService) {
        self.service = service
    }
}

// MARK: - Public Methods
extension HackerNewsViewModel {
    func fetchHackerNews() {
        service.fetchHackerNews { [weak self] result in
            guard let self = self else { return }
            self.hackerNews.value = result
        }
    }
}
