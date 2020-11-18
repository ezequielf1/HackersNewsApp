//
//  Dynamic.swift
//  HackerNewsApp
//
//  Created by Brian Ezequiel Fritz on 18/11/2020.
//

final class Dynamic<T> {
    typealias Listener = (T) -> ()
    private var listener: Listener?
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
