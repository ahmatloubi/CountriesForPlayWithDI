//
//  CountryDetailViewModel.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import Foundation
import Combine

class CountryDetailViewModel: ObservableObject {
    @Published public var name: String
    @Published public var capital: String
    
    let model: Country
    
    init(country: Country) {
        self.model = country
        self.name = country.name
        self.capital = country.capital
    }
}
