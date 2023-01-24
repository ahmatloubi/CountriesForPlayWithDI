//
//  Countainer.swift
//  CountriesForPlayWithDI
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import Foundation
import CoreData
import Combine

class Container: ObservableObject {
    let navigationViewModel = CountriesNavigationViewModel()
    let countriesFlowContainer = CountriesFlowContainer()
}

class CountriesFlowContainer {
    
    private var _countryListViewModel: CountriesListViewModel?
    private var _createCountryViewModel: CreateCountryViewModel?
    
    private var countriesServices: CountriesServices?
    
    private let name = "CoreDataModel"
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()
    
    private func makeService() -> CountriesServices {
        let service = CountriesServices(cacheService: getCacheService())
        countriesServices = service
        return service
    }
    
    func countryListViewModel() -> CountriesListViewModel  {
        let viewModel = CountriesListViewModel(services: makeService())
        _countryListViewModel = viewModel
        return viewModel
    }
    
    func createCountryViewModel() -> CreateCountryViewModel {
        let viewModel = CreateCountryViewModel(service: countriesServices ?? makeService())
        _createCountryViewModel = viewModel
        return viewModel
    }
    
    func createCountryDetailViewModel(for country: Country) -> CountryDetailViewModel {
        CountryDetailViewModel(country: country)
    }
}

extension CountriesFlowContainer {
    private func getManagedObjectModel() -> NSManagedObjectModel {
        guard let url = Bundle.main.url(forResource: name, withExtension: "momd") else {
            fatalError("Failed to locate momd file for xcdatamodeld")
        }
        guard let model = NSManagedObjectModel(contentsOf: url) else {
            fatalError("Failed to load momd file for xcdatamodeld")
        }
        return model
    }
    
    private func getPersistenceContainer() -> NSPersistentContainer {
        let container = NSPersistentContainer(name: name, managedObjectModel: getManagedObjectModel())
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
            
            container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        })
        return container
    }
    
    private func getCacheService() -> CacheServiceProtocol {
        let entityName = "Cache"
        let serviceModel = CoreDataService.Model(container: getPersistenceContainer(),
                              entityName: entityName,
                              jsonDecoder: jsonDecoder,
                              jsonEncoder: jsonEncoder)
        return CoreDataService(coreDataServiceModel: serviceModel)
    }
}

class ServiceToInject {
    
}
