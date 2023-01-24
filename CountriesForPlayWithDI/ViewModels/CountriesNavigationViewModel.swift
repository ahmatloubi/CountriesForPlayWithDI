//
//  CountriesNavigationViewModel.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import Foundation

class CountriesNavigationViewModel: ObservableObject {
    enum NavigationPathItem {
        case main, detail(Country)
    }
    
    @Published var navigationPath: [NavigationPathItem] = []
}
