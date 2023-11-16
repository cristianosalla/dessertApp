//
//  DessertListViewModelTest.swift
//  FetchCodeChallengeTests
//
//  Created by Cristiano Salla Lunardi on 11/3/23.
//

import XCTest
@testable import FetchCodeChallenge

class DessertListViewModelTests: XCTestCase {

    var viewModel: DessertListViewModel!

    override func setUpWithError() throws {
        viewModel = DessertListViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testViewTexts() {
        XCTAssertEqual(self.viewModel.alertText, "Couldn't load list of desserts.")
        XCTAssertEqual(self.viewModel.alertButton, "Try again")
        XCTAssertEqual(self.viewModel.title, "Dessert List")
    }
    
    func testFetchListSuccess() {
        let expectation = XCTestExpectation(description: "Fetch List Expectation Success")
        
        self.viewModel.fetchList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertFalse(self.viewModel.meals.isEmpty, "Fetched list should not be empty")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchListFailure() {
        let expectation = XCTestExpectation(description: "Fetch List Expectation Failure")

        guard let url = URL(string: "http://dummyurl") else {
            XCTFail()
            return
        }
        
        self.viewModel.fetchList(url)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.viewModel.showAlert, "Should show alert")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
}
