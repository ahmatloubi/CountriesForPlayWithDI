//
//  NavigationView.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import SwiftUI

struct CountriesnavigationView<Root: View>: View {
    @ObservedObject var countriesNavigationViewModel: CountriesNavigationViewModel
    var rootView: () -> Root
    
    var body: some View {
        NavigationStack(path: $countriesNavigationViewModel.navigationPath) {
            rootView()
        }
    }
}
