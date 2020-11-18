//
//  APIError.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

struct InvalidURLError: NetworkError {
    var message = "Invalid URL"
}

struct RequestFailureError: NetworkError {
    var message = "Request failed"
}

struct DecodingError: NetworkError {
    var message = "Decoding error"
}

struct UnknownError: NetworkError {
    var message = "Unknown error"
}

struct InternalServerError: NetworkError {
    var message: String
    
    init(message: String) {
        self.message = message
    }
}
