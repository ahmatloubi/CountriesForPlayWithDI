//
//  PersistanceContainer.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import Foundation
import CoreData

class PersistanceHelper {
    let persistentName: String
    let managedObjectModel: NSManagedObjectModel
    
    init(persistentName: String, managedObjectModel: NSManagedObjectModel) {
        self.persistentName = persistentName
        self.managedObjectModel = managedObjectModel
    }
    
    func getPersistentContainer() -> NSPersistentContainer {
        NSPersistentContainer(name: persistentName, managedObjectModel: managedObjectModel)
    }
}
