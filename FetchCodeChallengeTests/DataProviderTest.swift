//
//  DataProviderTests.swift
//  FetchCodeChallengeTests
//
//  Created by Cristiano Salla Lunardi on 11/3/23.
//

import XCTest
@testable import FetchCodeChallenge

class DataProviderTests: XCTestCase {

    var dataProvider: DataProvider!

    override func setUpWithError() throws {
        dataProvider = DataProvider()
    }

    override func tearDownWithError() throws {
        dataProvider = nil
    }
    
    func testFetchObjectSuccess() {
        let expectation = XCTestExpectation(description: "Fetch List Expectation Success")

        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            XCTFail("Could not create URL")
            return
        }
        
        dataProvider.fetchObject(from: url, completion: { (result: Result<MealList, Error>) in
            switch result {
            case .success(let meal):
                XCTAssertFalse(meal.meals.isEmpty, "Fetched list should not be empty")
            default:
                XCTFail("Result should be success")
            }
            expectation.fulfill()
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchListFailure() {
        let expectation = XCTestExpectation(description: "Fetch List Expectation Failure")

        guard let url = URL(string: "http://failurl") else {
            XCTFail("Could not create URL")
            return
        }
        
        dataProvider.fetchObject(from: url, completion: { (result: Result<MealList, Error>) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error, "Error should not be nil")
                expectation.fulfill()
            default:
                XCTFail("Result should be failure")
            }
        })

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchImageDataSuccess() {
        let expectation = XCTestExpectation(description: "Fetch Image Data Expectation Success")

        let validThumbnailURL = "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"
        dataProvider.fetchImageData(thumbnailURLString: validThumbnailURL) { result in
            switch result {
            case .success(let data):
                XCTAssertNotNil(data, "Fetched image data should not be nil")
                expectation.fulfill()
            case .failure(_):
                XCTFail()
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchImageDataFailure() {
        let expectation = XCTestExpectation(description: "Fetch Image Data Expectation Failure")

        let invalidThumbnailURL = "invalid thumbnail URL"
        dataProvider.fetchImageData(thumbnailURLString: invalidThumbnailURL) { result in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertNotNil(error, "Error should not be nil")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }
}
