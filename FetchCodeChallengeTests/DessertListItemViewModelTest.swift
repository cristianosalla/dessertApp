//
//  DessertListItemViewModelTest.swift
//  FetchCodeChallengeTests
//
//  Created by Cristiano Salla Lunardi on 11/8/23.
//

import XCTest
@testable import FetchCodeChallenge

class DessertListItemViewModelTest: XCTestCase {
    
    var viewModel: DessertListItemViewModel!

    override func setUpWithError() throws {
        let url = "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"
        viewModel = DessertListItemViewModel(url: url, meal: "Banana Pancakes")
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testGetThumbSuccess() {
        let expectation = XCTestExpectation(description: "Get Thumb Expectation Success")
        
        self.viewModel = DessertListItemViewModel(url: "http//url", meal: "", dataProvider: MockImageProviderSuccess())
        
        viewModel.getThumb { data in
            XCTAssertNotNil(data, "Fetched image data should not be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: TestConfigs().timeout)
    }
    
    func testGetThumbFailure() {
        let expectation = XCTestExpectation(description: "Get Thumb Expectation Failure")
        
        self.viewModel.url = "adxcbq1619787919.jpg"
        self.viewModel = DessertListItemViewModel(url: "http//url", meal: "", dataProvider: MockImageProviderError())
        
        viewModel.getThumb { data in
            XCTAssertNil(data, "Image should be nil")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: TestConfigs().timeout)
    }

}
