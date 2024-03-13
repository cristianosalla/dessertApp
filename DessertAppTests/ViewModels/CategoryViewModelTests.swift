import XCTest
@testable import DessertApp

class CategoryViewModelTests: XCTestCase {
    
    var viewModel: CategoryViewModel!
    
    override func setUpWithError() throws {
        viewModel = CategoryViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testViewTexts() {
        XCTAssertEqual(self.viewModel.title, "Category List")
    }
    
    func testFetchListSuccess() async {
        let categories = [
            Categories(idCategory: "", strCategory: "", strCategoryThumb: "", strCategoryDescription: ""),
            Categories(idCategory: "", strCategory: "", strCategoryThumb: "", strCategoryDescription: ""),
            Categories(idCategory: "", strCategory: "", strCategoryThumb: "", strCategoryDescription: ""),
            Categories(idCategory: "", strCategory: "", strCategoryThumb: "", strCategoryDescription: "")
        ]
        
        let category = Category(categories: categories)
        
        let mockObject = MockObjectProviderSuccess(object: category)
        self.viewModel = CategoryViewModel(dataProvider: mockObject)
        
        do {
            await viewModel.fetchList()
            XCTAssertFalse(self.viewModel.categories.isEmpty, "Fetched list should not be empty")
        }
    }
    
    func testFetchListFailure() async {
        self.viewModel = CategoryViewModel(dataProvider: MockObjectProviderError())
        
        do {
            await viewModel.fetchList()
            XCTAssertTrue(self.viewModel.showAlert, "Should show alert")
        }
    }
    
    func testFetchListObject() {
         
        guard let fileURL = Bundle.main.url(forResource: "Category", withExtension: "json") else {
            XCTFail()
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let categories = try decoder.decode(Category.self, from: jsonData)
            XCTAssertNotNil(categories)
        } catch {
            XCTFail()
        }
    }
    
}
