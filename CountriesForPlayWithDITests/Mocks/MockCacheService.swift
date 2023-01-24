//
//  MockCacheService.swift
//  CountriesForPlayWithDITests
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import Foundation
@testable import CountriesForPlayWithDI

class MockCacheService<Item: Codable>: CacheServiceProtocol {
    var items: [Item]
    
    init(items: [Item]) {
        self.items = items
    }
    
    func load<T>(key: String, of type: T.Type) -> T? where T : Decodable, T : Encodable {
        return items as? T
    }
    
    func cache<T>(for key: String, value: T) where T : Decodable, T : Encodable {
        if let items = value as? [Item] {
            self.items = items
        }
    }
}
