//
//  HackerNewsService.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

import Foundation

final class HackerNewsService {
    typealias Model = [HackerNew]
    private let networkManager: NetworkManager
    private let cacheManager: MemoryCacheManager<Model>
    private let lastHackerNewsKey = "last_hacker_news"
    
    init(networkManager: NetworkManager = NetworkManagerImplementation.shared,
         cacheManager: MemoryCacheManager<Model> = .init()) {
        self.networkManager = networkManager
        self.cacheManager = cacheManager
    }
    
    func fetchHackerNews(completionHandler: @escaping (Model) -> Void) {
        let request = APIRequest(request: HackerNewsRequest())
        request.queryItems = [URLQueryItem(name: "query", value: "ios")]
        networkManager.doRequest(request) { [weak self] (result: APIResult<HackerNews>) in
            guard let self = self else { return }
            switch result {
            case .success(let hackerNews):
                let hits = hackerNews?.hits ?? []
                self.cacheManager.put(key: self.lastHackerNewsKey, value: hits)
                completionHandler(hits)
            case .failure:
                completionHandler(self.cacheManager.get(key: self.lastHackerNewsKey) ?? [])
            }
        }
    }
}
