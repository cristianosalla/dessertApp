//
//  DataProviderTests.swift
//  FetchCodeChallengeTests
//
//  Created by Cristiano Salla Lunardi on 11/3/23.
//

import XCTest
@testable import FetchCodeChallenge


struct MockHttpClientSuccess<T: Encodable>: HTTPClient {
    
    var data: Data
    
    init(object: T) {
        do {
            self.data = try JSONEncoder().encode(object)
        } catch {
            self.data = Data()
        }
    }
    
    init(data: Data) {
        self.data = data
    }
    
    func get(url: URL) async -> Result<Data, Error> {
        return .success(data)
    }
}

struct MockHttpClientError: HTTPClient {
    func get(url: URL) async -> Result<Data, Error> {
        return .failure(DataProvider.DataProviderError.noData)
    }
}

class DataProviderTests: XCTestCase {

    var dataProvider: DataProvider!

    override func setUpWithError() throws {
        dataProvider = DataProvider()
    }

    override func tearDownWithError() throws {
        dataProvider = nil
    }
    
    func testFetchObjectSuccess() async {
        guard let url = URL(string: "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert") else {
            XCTFail("Could not create URL")
            return
        }
        
        let mealObject = Meal(idMeal: "", strMeal: "", strMealThumb: "")
        let client = MockHttpClientSuccess(object: mealObject)
        self.dataProvider = DataProvider(httpClient: client)
        
        let result: Result<Meal, Error> = await self.dataProvider.fetchObject(from: url)
        switch result {
        case .success(let meal):
            XCTAssertEqual(mealObject, meal, "Should be the same object")
        default:
            XCTFail("Result should be success")
        }
    }
    
    func testFetchListFailure() async {
        guard let url = URL(string: "http://failurl") else {
            XCTFail("Could not create URL")
            return
        }
        
        self.dataProvider = DataProvider(httpClient: MockHttpClientError())
        let result: Result<Data, Error> = await dataProvider.fetchObject(from: url)
        switch result {
        case .failure(let error):
            XCTAssertNotNil(error, "Error should not be nil")
        default:
            XCTFail("Result should be failure")
        }
        
    }
    
    func testFetchImageDataSuccess() async {
        let validThumbnailURL = "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"
        
        let image = Data()
        let client = MockHttpClientSuccess<Data>(data: image)
        self.dataProvider = DataProvider(httpClient: client)
        
        let result = await dataProvider.fetchImageData(thumbnailURLString: validThumbnailURL)
        switch result {
        case .success(let data):
            XCTAssertEqual(image, data, "Should be the same object")
        default:
            XCTFail("Error trying to get image")
        }
        
    }
    
    func testFetchImageDataFailure() async {
        let invalidThumbnailURL = "invalid thumbnail URL"
        
        let client = MockHttpClientError()
        self.dataProvider = DataProvider(httpClient: client)
        
        let result = await dataProvider.fetchImageData(thumbnailURLString: invalidThumbnailURL)
        switch result {
        case .failure(let error):
            XCTAssertNotNil(error, "Error should not be nil")
        default:
            XCTFail()
        }
    }
}
