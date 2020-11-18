//
//  Mocks.swift
//  HackerNewsAppTests
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

import Foundation
@testable import HackerNewsApp

struct MockInvalidURLAPIRequest: NetworkRequest {
    var baseURL: URL? = nil
    var path = ""
    var httpMethod: HTTPMethod = .get
}

struct MockPutAPIRequest: NetworkRequest {
    var baseURL: URL? = URL(string: "TestUrl")
    var path = ""
    var httpMethod: HTTPMethod = .put
}

final class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void

    init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    override func resume() {
        closure()
    }
}

final class URLSessionMock: URLSession {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    var data: Data?
    var error: Error?
    var response: URLResponse?

    override func dataTask(with url: URL,
                           completionHandler: @escaping CompletionHandler) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        let response = self.response
        return URLSessionDataTaskMock {
            completionHandler(data, response, error)
        }
    }
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        let data = self.data
        let error = self.error
        let response = self.response
        return URLSessionDataTaskMock {
            completionHandler(data,
                              response,
                              error)
        }
    }
}

struct MockResponse: Codable, Equatable {
    let mockFirstProperty: String
    let mockSecondProperty: String
}

