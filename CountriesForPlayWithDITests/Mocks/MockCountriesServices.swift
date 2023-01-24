//
//  MockCountriesListViewModel.swift
//  CountriesForPlayWithDITests
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import Foundation
import CountriesForPlayWithDI
import Combine

class MockCountriesServices: CountriesServicesProtocol {
    let stateSubject = PassthroughSubject<CountryListState, Never>()
    
    var viewStatePublisher: AnyPublisher<CountryListState, Never> {
        stateSubject.eraseToAnyPublisher()
    }
    
    var loadMethod: (() -> Void)?
    
    func load() {
        loadMethod?()
    }
}
