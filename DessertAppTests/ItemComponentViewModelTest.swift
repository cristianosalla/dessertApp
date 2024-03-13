import XCTest
@testable import DessertApp

class ItemComponentViewModelTest: XCTestCase {
    
    var viewModel: ItemComponentViewModel!

    override func setUpWithError() throws {
        let url = "https://www.themealdb.com/images/media/meals/adxcbq1619787919.jpg"
        viewModel = ItemComponentViewModel(url: url, text: "Banana Pancakes")
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testGetThumbSuccess() async {
        self.viewModel = ItemComponentViewModel(url: "http//url", text: "", dataProvider: MockImageProviderSuccess())
        
        let data = try? await viewModel.getThumb()
        XCTAssertNotNil(data, "Fetched image data should not be nil")
    }
    
    func testGetThumbFailure() async {
        self.viewModel.url = "adxcbq1619787919.jpg"
        self.viewModel = ItemComponentViewModel(url: "http//url", text: "", dataProvider: MockImageProviderError())
        
        let data = try? await viewModel.getThumb()
        XCTAssertNil(data, "Fetched image data should be nil")
    }

}
