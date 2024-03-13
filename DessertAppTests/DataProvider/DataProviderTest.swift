import XCTest
@testable import DessertApp


class DataProviderTests: XCTestCase {

    var dataProvider: DataProvider!

    override func tearDownWithError() throws {
        dataProvider = nil
    }
    
    func testFetchObjectSuccess() async {
        let url = Endpoint.list("Dessert").url
        
        let mealObject = Meal(idMeal: "", strMeal: "", strMealThumb: "")
        let client = MockHttpClientSuccess(object: mealObject)
        self.dataProvider = DataProvider(httpClient: client)
        
        
        do {
            let meal: Meal = try await self.dataProvider.fetchObject(from: url)
            XCTAssertEqual(mealObject, meal, "Should be the same object")
        } catch {
            XCTFail("Result should be success")
        }
    }
    
    func testFetchObjectFailure() async {
        guard let url = URL(string: "http://failurl") else {
            XCTFail("Could not create URL")
            return
        }
        
        self.dataProvider = DataProvider(httpClient: MockHttpClientError())
        
        var errorResult: Error?
        do {
            let _: Data = try await dataProvider.fetchObject(from: url)
        } catch(let error) {
            errorResult = error
        }
        
        XCTAssertNotNil(errorResult, "Error should not be nil")
    }
    
    func testFetchListDecodeFailure() async {
        let url = Endpoint.list("Dessert").url
        
        let mealObject = ""
        let client = MockHttpClientSuccess(object: mealObject)
        self.dataProvider = DataProvider(httpClient: client)
        
        var errorResult: DataProvider.DataProviderError?
        do {
            let _: Meal = try await dataProvider.fetchObject(from: url)
        } catch(let error) {
            if let err = error as? DataProvider.DataProviderError {
                errorResult = err
            }
        }
        
        XCTAssertNotNil(errorResult, "Error should not be nil")
        XCTAssertEqual(errorResult, DataProvider.DataProviderError.decode, "Should be decode error")
    }
    
    func testFetchImageDataSuccess() async {
        let validThumbnailURL = "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"
        
        let image = Data()
        let client = MockHttpClientSuccess<Data>(data: image)
        self.dataProvider = DataProvider(httpClient: client)
        
        do {
            let result = try await dataProvider.fetchImageData(thumbnailURLString: validThumbnailURL)
            XCTAssertEqual(image, result, "Should be the same object")
        } catch {
            XCTFail()
        }
        
    }
    
    func testFetchImageDataFailure() async {
        let invalidThumbnailURL = "http://www.fail.com"
        
        let client = MockHttpClientError()
        self.dataProvider = DataProvider(httpClient: client)
        
        var errorResult: Error?
        do {
            let _ = try await dataProvider.fetchImageData(thumbnailURLString: invalidThumbnailURL)
        } catch(let error) {
            errorResult = error
        }
        
        XCTAssertNotNil(errorResult, "Error should not be nil")
    }
    
    func testFetchImageDataUrlError() async {
        let invalidThumbnailURL = ""
        
        let client = MockHttpClientError()
        self.dataProvider = DataProvider(httpClient: client)
        
        var errorResult: DataProvider.DataProviderError?
        do {
            let _ = try await dataProvider.fetchImageData(thumbnailURLString: invalidThumbnailURL)
        } catch(let error) {
            if let err = error as? DataProvider.DataProviderError {
                errorResult = err
            }
        }
        
        XCTAssertNotNil(errorResult, "Error should not be nil")
        XCTAssertEqual(errorResult, DataProvider.DataProviderError.url, "Should be URL error")
    }
}
