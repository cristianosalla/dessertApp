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
        viewModel = DessertDetailsViewModel()
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

        let instructions = "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm."

        let dummyId = "53049"
        viewModel.fetchDetails(id: dummyId)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNotNil(self.viewModel.meal, "Object should not be nil")
            XCTAssertFalse(self.viewModel.showAlert, "Should not show alert")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchFailure() {
        let expectation = XCTestExpectation(description: "Fetch Details Expectation Failure")

        let dummyId = "1111"
        viewModel.fetchDetails(id: dummyId)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNil(self.viewModel.meal, "Object should be nil")
            XCTAssertTrue(self.viewModel.showAlert, "Should show alert")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
}
