//
//  NetworkError.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

protocol NetworkError: Error, Codable {
    var title: String { get set }
    var message: String { get set }
}

extension NetworkError {
    var title: String { get { "Error" } set {} }
}
