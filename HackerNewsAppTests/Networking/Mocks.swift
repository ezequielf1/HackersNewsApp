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

final class NetworkManagerMock<T: Codable>: NetworkManager {
    var response: APIResult<T>?
    var timesCalled = 0
    
    func doRequest<T>(_ request: APIRequest,
                      _ completion: @escaping APIClientCompletion<T>) where T : Decodable, T : Encodable {
        timesCalled += 1
        switch response {
        case .success(let value):
            completion(.success(value as? T))
        case .failure(let error):
            completion(.failure(error))
        default:
            completion(.success(nil))
        }
    }
}

final class CacheManagerMock<T: Codable>: MemoryCacheManager<T> {
    var timesCalled = 0
    var dictionary: [String: T] = [:]
    
    override func get(key: String) -> T? {
        timesCalled += 1
        return dictionary[key]
    }
    
    override func put(key: String, value: T) {
        dictionary[key] = value
    }
}

