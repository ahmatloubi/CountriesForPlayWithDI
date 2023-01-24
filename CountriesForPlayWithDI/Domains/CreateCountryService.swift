//
//  CreateCountryService.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import Foundation

public protocol CreateCountryProtocol {
    func doneCreatingCountry(_ country: Country)
    func cancelCreatingCountry()
}
