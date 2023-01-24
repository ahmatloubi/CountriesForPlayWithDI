//
//  CountriesForPlayWithDIApp.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import SwiftUI

@main
struct CountriesForPlayWithDIApp: App {
    @StateObject var container: Container = Container()
    
    var body: some Scene {
        WindowGroup {
            CountriesnavigationView(countriesNavigationViewModel: container.navigationViewModel) {
                CountryListView(viewModel: container.countriesFlowContainer.countryListViewModel())
            }
            .environmentObject(container)
        }
    }
}
