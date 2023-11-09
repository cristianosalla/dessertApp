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
        let expectation = XCTestExpectation(description: "View texts should match")
        
        XCTAssertEqual(self.viewModel.errorAlertText, "Couldn't load dessert details.")
        XCTAssertEqual(self.viewModel.errorAlertButton, "Try again")
        XCTAssertEqual(self.viewModel.instructionsTitle, "Instructions")
        XCTAssertEqual(self.viewModel.ingredientsTitle, "Ingredients")
        
        expectation.fulfill()
    }
    
    func testMeasureIngredientFormat() {
        let expectation = XCTestExpectation(description: "Should format ingredients and measures")
        
        let ingredient = "Plain Flour"
        let measure = "120g"
        
        let formattedText = self.viewModel.ingredientMeasureFormat(ingredient: ingredient, measure: measure)
        
        XCTAssertEqual(formattedText, "• 120g Plain Flour")
        
        expectation.fulfill()
    }

    func testFetchDetailsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch Details Expectation Success")
        
        let instructions = "Mix milk, oil and egg together. Sift flour, baking powder and salt into the mixture. Stir well until all ingredients are combined evenly.\r\n\r\nSpread some batter onto the pan. Spread a thin layer of batter to the side of the pan. Cover the pan for 30-60 seconds until small air bubbles appear.\r\n\r\nAdd butter, cream corn, crushed peanuts and sugar onto the pancake. Fold the pancake into half once the bottom surface is browned.\r\n\r\nCut into wedges and best eaten when it is warm."

        let dummyId = "53049"
        viewModel.fetchDetails(id: dummyId)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertEqual(self.viewModel.title, "Apam balik", "Title should match")
            XCTAssertEqual(self.viewModel.instructions, instructions, "Instructions should match")
            XCTAssertEqual(self.viewModel.url, URL(string: "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"), "URL should match")
            XCTAssertFalse(self.viewModel.ingredientsAndMeasures.isEmpty, "Ingredients and Measures should not be empty")
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
            XCTAssertEqual(self.viewModel.title, "", "Title should match")
            XCTAssertEqual(self.viewModel.instructions, "", "Instructions should match")
            XCTAssertEqual(self.viewModel.url, URL(string: ""), "URL should match")
            XCTAssertTrue(self.viewModel.ingredientsAndMeasures.isEmpty, "Ingredients and Measures should be empty")
            XCTAssertTrue(self.viewModel.showAlert, "Should show alert")

            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
}
