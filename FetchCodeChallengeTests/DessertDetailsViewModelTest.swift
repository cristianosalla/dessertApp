//
//  DessertDetailsViewModelTest.swift
//  FetchCodeChallengeTests
//
//  Created by Cristiano Salla Lunardi on 11/3/23.
//

import XCTest
@testable import FetchCodeChallenge

class DessertDetailsViewModelTests: XCTestCase {

    var viewModel: DessertDetailsViewModel!

    override func setUpWithError() throws {
        viewModel = DessertDetailsViewModel(id: "")
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testViewTexts() {
        XCTAssertEqual(self.viewModel.errorAlertText, "Couldn't load dessert details.")
        XCTAssertEqual(self.viewModel.errorAlertButton, "Try again")
        XCTAssertEqual(self.viewModel.instructionsTitle, "Instructions")
        XCTAssertEqual(self.viewModel.ingredientsTitle, "Ingredients")
    }
    
    func testMeasureIngredientFormat() {
        let ingredient = "Plain Flour"
        let measure = "120g"
        
        let formattedText = self.viewModel.ingredientMeasureFormat(ingredient: ingredient, measure: measure)
        
        XCTAssertEqual(formattedText, "• 120g Plain Flour")
    }

    func testFetchDetailsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch Details Expectation Success")

        let dummyId = "53049"
        
        let meal = MealDetail()
        let meals = MealsDetails(meals: [meal])
        
        viewModel = DessertDetailsViewModel(id: "", dataProvider: MockObjectProviderSuccess(object: meals))
        viewModel.fetchDetails(id: dummyId) {
            XCTAssertNotNil(self.viewModel.meal, "Object should not be nil")
            XCTAssertFalse(self.viewModel.showAlert, "Should not show alert")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 0.5)
    }
    
    func testFetchFailure() {
        let expectation = XCTestExpectation(description: "Fetch Details Expectation Failure")

        let dummyId = "1111"
        self.viewModel = DessertDetailsViewModel(id: "", dataProvider: MockObjectProviderError())
        viewModel.fetchDetails(id: dummyId) {
            XCTAssertNil(self.viewModel.meal, "Object should be nil")
            XCTAssertTrue(self.viewModel.showAlert, "Should show alert")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 0.5)
    }
    
}
