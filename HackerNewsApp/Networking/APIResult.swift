//
//  APIResult.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

enum APIResult<Body> {
    case success(Body?)
    case failure(NetworkError)
}
