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
    
    func testSavingImage() async {
        let validUrl = "http://url.com"
        
        let image = Data()
        
        let client = MockHttpClientSuccess<Data>(data: image)
        let cache = NSCache<AnyObject, AnyObject>()
        self.dataProvider = DataProvider(httpClient: client, cache: cache)
        
        do {
            let result = try await dataProvider.fetchImageData(thumbnailURLString: validUrl)
            XCTAssertEqual(image, result, "Should be the same object")
            let cachedObject = cache.object(forKey: validUrl as AnyObject)
            XCTAssertNotNil(cachedObject)
            XCTAssertEqual(result, cachedObject as! Data)
        } catch {
            XCTFail()
        }
    }
    
    func testRetrievingImage() async {
        let validUrl = "http://url.com"
        
        let image = Data(repeating: 10, count: 10)
        let image2 = Data(repeating: 15, count: 15)
        XCTAssertNotEqual(image, image2)
        
        let client = MockHttpClientSuccess<Data>(data: image)
        let client2 = MockHttpClientSuccess<Data>(data: image2)
        
        let cache = NSCache<AnyObject, AnyObject>()
        self.dataProvider = DataProvider(httpClient: client, cache: cache)
        
        do {
            let result = try await dataProvider.fetchImageData(thumbnailURLString: validUrl)
            XCTAssertEqual(result, image)
            
            dataProvider.httpClient = client2
            let result2 = try await dataProvider.fetchImageData(thumbnailURLString: validUrl)
            
            XCTAssertEqual(result, result2)
            XCTAssertNotEqual(result2, image2)
        } catch {
            XCTFail()
        }
    }
    
    func testReturnCachedImage() {
        let validUrl = "http://url.com"
        
        let image = Data(repeating: 10, count: 10)
        let cache = NSCache<AnyObject, AnyObject>()
        
        cache.setObject(image as AnyObject, forKey: validUrl as AnyObject)
        
        self.dataProvider = DataProvider(cache: cache)
        let data = dataProvider.getCachedImage(url: validUrl)!
        
        XCTAssertNotNil(data)
        XCTAssertEqual(image, data)
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
