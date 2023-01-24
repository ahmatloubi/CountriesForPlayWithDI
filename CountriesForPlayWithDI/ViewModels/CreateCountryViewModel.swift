//
//  CreateCountryViewModel.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import Foundation

class CreateCountryViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var capital: String = ""
    @Published var isPresented: Bool = false
    
    let service: CreateCountryProtocol
        
    init(service: CreateCountryProtocol) {
        self.service = service
    }
    
    func onTapDoneButton() {
        let country = Country(name: name, capital: capital, flag: "")
        service.doneCreatingCountry(country)
    }
    
    func onTapCancel() {
        service.cancelCreatingCountry()
    }
}
