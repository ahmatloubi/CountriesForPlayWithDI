//
//  MainViewModel.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import Foundation

class MainViewModel: ObservableObject {
    
    let services: MainViewServices
    @Published public var countries: [Countries]
    
    init(services: MainViewServices) {
        self.services = services
        self.countries = services.initialCountries
    }
    
}
