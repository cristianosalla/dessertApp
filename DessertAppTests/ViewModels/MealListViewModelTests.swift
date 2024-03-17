import XCTest
@testable import DessertApp

class MealListViewModelTests: XCTestCase {

    var viewModel: MealListViewModel!

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testViewTexts() {
        self.viewModel = MealListViewModel(category: "Dessert", dataProvider: MockObjectProviderError())
        XCTAssertEqual(self.viewModel.title, "Dessert List")
    }
    
    func testFetchListSuccess() async {
        let meal = Meal(idMeal: "", strMeal: "aaa", strMealThumb: "")
        let meal2 = Meal(idMeal: "", strMeal: "bbb", strMealThumb: "")
        let list = MealList(meals: [meal2, meal])
        
        self.viewModel = MealListViewModel(category: "Dessert", dataProvider: MockObjectProviderSuccess(object: list))
        
        do {
            await viewModel.fetchList()
            XCTAssertFalse(self.viewModel.meals.isEmpty, "Fetched list should not be empty")
        }
    }
    
    func testFetchListFailure() async {
        self.viewModel = MealListViewModel(category: "Dessert", dataProvider: MockObjectProviderError())
        
        do {
            await viewModel.fetchList()
            XCTAssertTrue(self.viewModel.showAlert, "Should show alert")
        }
    }
    
    func testFetchListObject() {
         
        guard let fileURL = Bundle.main.url(forResource: "MealsList", withExtension: "json") else {
            XCTFail()
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let meals = try decoder.decode(MealList.self, from: jsonData)
            XCTAssertNotNil(meals)
        } catch {
            XCTFail()
        }
    }
    
}
