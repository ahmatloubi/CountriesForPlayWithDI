//
//  CacheService.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import Foundation
import CoreData

class CoreDataService: CacheServiceProtocol {
    struct Model {
        let container: NSPersistentContainer
        let entityName: String
        let jsonDecoder: JSONDecoder
        let jsonEncoder: JSONEncoder
    }
    
    let model: Model
    
    private var context: NSManagedObjectContext {
        model.container.viewContext
    }
    
    private var encoder: JSONEncoder {
        model.jsonEncoder
    }
    
    private var decoder: JSONDecoder {
        model.jsonDecoder
    }
    
    private var entityName: String {
        model.entityName
    }

    init(coreDataServiceModel: Model) {
        self.model = coreDataServiceModel
    }
    
    func load<T: Codable>(key: String, of type: T.Type) -> [T]? {
        let fetchRequest = Cache.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "key = %@", key)
        guard let cacheObject = try? context.fetch(fetchRequest).first, let resultData = cacheObject.value as? Data else {
            return nil }
        
        do {
            return try decoder.decode([T].self, from: resultData)
        } catch let error {
            print(error)
            return nil
        }
    }
    
    func cache<T: Codable>(for key: String, value: T) {
        let entity = Cache(context: context)
        do {
            entity.value = try encoder.encode(value)
            entity.key = key
            
            try context.save()
        } catch {
            print("error happened cache object of typ : \(T.Type.self) , for key: \(key)")
        }
    }    
}

