//
//  APIRequests.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

final class HackerNewsRequest: NetworkRequest {
    var path = "api/v1/search_by_date"
    var httpMethod: HTTPMethod = .get
}
