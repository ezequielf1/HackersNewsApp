//
//  APIRequest.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

import Foundation

class APIRequest {
    let request: NetworkRequest
    var queryItems: [URLQueryItem]?
    var headers: [HTTPHeader]?
    var body: Data?
    
    init(request: NetworkRequest) {
        self.request = request
    }
}
