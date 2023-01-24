//
//  CountriesListServiceTests.swift
//  CountriesForPlayWithDITests
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import XCTest
import Combine
@testable import CountriesForPlayWithDI

extension CountryListState: Equatable {
    public static func == (lhs: CountryListState, rhs: CountryListState) -> Bool {
        switch (lhs, rhs)  {
        case (.loading, .loading):
            return true
        case (.emptyList, .emptyList):
            return true
        case (.list(let lhsCountries), .list(let rhsCountries)):
            return lhsCountries == rhsCountries
        default:
            return false
        }
    }
}

final class CountriesListServiceTests: XCTestCase {
    var sut: CountriesServices!
    var mockCacheServices: MockCacheService<Country>!
    let cacheKey = "key"

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockCacheServices = MockCacheService<Country>(items: [])
        sut = CountriesServices(cacheService: mockCacheServices)
        
    }

    override func tearDownWithError() throws {
        sut = nil
        mockCacheServices = nil
        try super.tearDownWithError()
    }
    
    func test_whenLoadMethodCalled_sendLoadState() {
        //given
        let expectation = expectation(description: "test fetch items")
        let cancellable = sut.viewStatePublisher.sink { newValue in
            if newValue == .loading {
                expectation.fulfill()
            }
        }
        //when
        sut.load()
        //then
        wait(for: [expectation], timeout: 2)
        cancellable.cancel()
    }
    
    func test_whenItemsFetched_sendListStateWithLoadedItems() {
        //given
        let countries: [Country] = [.init(name: "iran", capital: "tehrab", flag: "")]
        mockCacheServices.cache(for: cacheKey, value: countries)
        var newState = CountryListState.loading
        
        let cancellable = sut.viewStatePublisher.sink { newValue in
            newState = newValue
        }
        //when
        sut.load()
        //then
        XCTAssertEqual(newState, .list(countries))
        cancellable.cancel()
    }
    
    func test_whenItemsFetchedWithEmpty_sendEmptyState() {
        //given
        let countries: [Country] = []
        mockCacheServices.cache(for: cacheKey, value: countries)
        var newState = CountryListState.loading
        
        let cancellable = sut.viewStatePublisher.sink { newValue in
            newState = newValue
        }
        //when
        sut.load()
        //then
        XCTAssertEqual(newState, .emptyList)
        cancellable.cancel()
    }
}
