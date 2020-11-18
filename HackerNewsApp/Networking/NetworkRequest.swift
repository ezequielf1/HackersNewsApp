//
//  NetworkRequest.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

import Foundation

protocol NetworkRequest {
    var path: String { get set }
    var httpMethod: HTTPMethod { get set }
    var baseURL: URL? { get set }
}

extension NetworkRequest {
    var baseURL: URL? {
        get { URL(string: "https://hn.algolia.com?query=ios&page=3") }
        set {}
    }
}
