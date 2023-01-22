//
//  MainView.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var mainViewModel: MainViewModel
    @EnvironmentObject var container: Container
    
    init(mainViewModel: MainViewModel) {
        self.mainViewModel = mainViewModel
    }
    
    var body: some View {
        List {
            ForEach(mainViewModel.countries) { country in
                Text(country.string)
            }
        }
    }
}

