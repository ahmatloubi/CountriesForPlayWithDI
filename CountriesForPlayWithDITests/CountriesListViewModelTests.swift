//
//  CountriesListViewModelTests.swift
//  CountriesForPlayWithDITests
//
//  Created by AmirHossein Matloubi on 11/2/1401 AP.
//

import XCTest
@testable import CountriesForPlayWithDI

extension Country: Equatable {
    public static func == (lhs: Country, rhs: Country) -> Bool {
        lhs.id == rhs.id
    }
}

final class CountriesListViewModelTests: XCTestCase {
    var sut: CountriesListViewModel!
    var fakeService = MockCountriesServices()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = CountriesListViewModel(services: fakeService)
    }
    
    override func tearDownWithError() throws {
        sut = nil
        fakeService.loadMethod = nil
        try super.setUpWithError()
    }
    
    func test_whenInit_viewStateIsIntro() {
        XCTAssertEqual(sut.viewState, .loading)
    }
    
    func test_whenServicePublisheNewState_viewModelStateChange() {
        //given
        let testState = CountryListState.emptyList
        //when
        fakeService.stateSubject.send(testState)
        //then
        XCTAssertEqual(sut.viewState, testState)
    }
    
    func test_whenViewAppear_dataRequestCall() {
        //given
        let expectation = expectation(description: "load method called")
        
        fakeService.loadMethod = {
            expectation.fulfill()
        }
        //when
        sut.loadCountries()
        //then
        wait(for: [expectation], timeout: 2)
    }
    
    func test_whenAddCoutryCalled_shouldShowCountryViewIsTrue() {
        //when
        sut.onTapCreateCountryButton()
        //then
        XCTAssertTrue(sut.shouldPresentSelectCountryView)
       
    }
    
}
