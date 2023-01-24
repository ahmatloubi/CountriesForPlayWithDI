//
//  CountriesServices.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import Foundation
import Combine


protocol CacheServiceProtocol {
    func load<T: Codable>(key: String, of type: T.Type) -> [T]?
    func cache<T: Codable>(for key: String, value: T)
}

public enum CountryListState {
    case emptyList, list([Country]), loading
}

public enum CountryCreateState {
    case start, end
}

public protocol CountriesServicesProtocol {
    var listStatePublisher: AnyPublisher<CountryListState, Never> { get }
    var createCountryStatePublisher: AnyPublisher<CountryCreateState, Never> { get }
    func load()
    func startCreateNewCountry()
}

class CountriesServices: CountriesServicesProtocol {
    private let listStateSubject = CurrentValueSubject<CountryListState, Never>(.loading)
    private let createCountryStateSubject = PassthroughSubject<CountryCreateState, Never>()

    private let cacheService: CacheServiceProtocol
    private let cacheKey: String = "Countries"
    
    var listStatePublisher: AnyPublisher<CountryListState, Never> {
        listStateSubject.eraseToAnyPublisher()
    }
    var createCountryStatePublisher: AnyPublisher<CountryCreateState, Never> {
        createCountryStateSubject.eraseToAnyPublisher()
    }
    
    init(cacheService: CacheServiceProtocol) {
        self.cacheService = cacheService
    }
    
    func load() {
        listStateSubject.send(.loading)
        if let countries = cacheService.load(key: cacheKey, of: Country.self), !countries.isEmpty {
            listStateSubject.send(.list(countries))
        }  else {
            listStateSubject.send(.emptyList)
        }
    }
    
    func startCreateNewCountry() {
        createCountryStateSubject.send(.start)
    }
}

extension CountriesServices: CreateCountryProtocol {
    func doneCreatingCountry(_ country: Country) {
        cacheService.cache(for: cacheKey, value: country)
        if case .list(let countries) = listStateSubject.value {
            listStateSubject.send(.list(countries + [country]))
        } else {
            listStateSubject.send(.list([country]))
        }
        createCountryStateSubject.send(.end)
    }
    
    func cancelCreatingCountry() {
        createCountryStateSubject.send(.end)
    }
}
