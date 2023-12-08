import XCTest
@testable import DessertApp

class DessertListItemViewModelTest: XCTestCase {
    
    var viewModel: DessertListItemViewModel!

    override func setUpWithError() throws {
        let url = "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"
        viewModel = DessertListItemViewModel(url: url, meal: "Banana Pancakes")
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testGetThumbSuccess() async {
        self.viewModel = DessertListItemViewModel(url: "http//url", meal: "", dataProvider: MockImageProviderSuccess())
        
        let data = try? await viewModel.getThumb()
        XCTAssertNotNil(data, "Fetched image data should not be nil")
    }
    
    func testGetThumbFailure() async {
        self.viewModel.url = "adxcbq1619787919.jpg"
        self.viewModel = DessertListItemViewModel(url: "http//url", meal: "", dataProvider: MockImageProviderError())
        
        let data = try? await viewModel.getThumb()
        XCTAssertNil(data, "Fetched image data should be nil")
    }

}
