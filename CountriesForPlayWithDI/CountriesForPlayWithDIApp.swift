//
//  CountriesForPlayWithDIApp.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import SwiftUI

@main
struct CountriesForPlayWithDIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
