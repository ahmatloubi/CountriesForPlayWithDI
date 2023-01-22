//
//  Countainer.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import Foundation

class Container: ObservableObject {
    let navigationViewModel = CountriesNavigationViewModel()
    
    let mainViewServices = MainViewServices()
    
    func makeMainViewModel() -> MainViewModel  {
        MainViewModel(services: mainViewServices)
    }
}
