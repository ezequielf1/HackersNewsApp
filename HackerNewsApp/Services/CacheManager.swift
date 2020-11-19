//
//  CacheManager.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 19/11/2020.
//

import Foundation

protocol CacheManager {
    associatedtype T: Codable
    func get(key: String) -> T?
    func put(key: String, value: T)
}

class MemoryCacheManager<T: Codable>: CacheManager {
    private let userDefaults: UserDefaults = .standard
    
    func get(key: String) -> T? {
        guard let data = userDefaults.object(forKey: key) as? Data else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
    
    func put(key: String, value: T) {
        if let encoded = try? JSONEncoder().encode(value) {
            userDefaults.setValue(encoded, forKey: key)
        }
    }
}
