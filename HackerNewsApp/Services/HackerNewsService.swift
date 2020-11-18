//
//  HackerNewsService.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

import Foundation

final class HackerNewsService {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = NetworkManagerImplementation.shared) {
        self.networkManager = networkManager
    }
    
    func fetchHackerNews(completionHandler: @escaping (APIResult<HackerNews>) -> Void) {
        let request = APIRequest(request: HackerNewsRequest())
        request.queryItems = [URLQueryItem(name: "query", value: "ios")]
        networkManager.doRequest(request) { (result: APIResult<HackerNews>) in
            completionHandler(result)
        }
    }
}
