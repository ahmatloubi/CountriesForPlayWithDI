//
//  MainViewModel.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import Foundation
import Combine

class CountriesListViewModel: ObservableObject {
    
    let services: CountriesServicesProtocol
    @Published public var viewState: CountryListState = .loading
    @Published public var emptyMessage: String = "There is no country to show"
    @Published public var shouldPresentSelectCountryView: Bool = false
    
    
    init(services: CountriesServicesProtocol) {
        self.services = services
        setPublishers()
    }
    
    func setPublishers() {
        services
            .listStatePublisher
            .assign(to: &$viewState)
        
        services
            .createCountryStatePublisher
            .map { $0 == .start }
            .assign(to: &$shouldPresentSelectCountryView)
    }
    
    func loadCountries() {
        services.load()
    }
    
    func onTapCreateCountryButton() {
        services.startCreateNewCountry()
    }
}
