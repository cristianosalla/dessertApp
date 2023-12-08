import XCTest
@testable import DessertApp

class DessertListViewModelTests: XCTestCase {

    var viewModel: DessertListViewModel!

    override func setUpWithError() throws {
        viewModel = DessertListViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testViewTexts() {
        XCTAssertEqual(self.viewModel.alertText, "Couldn't load list of desserts.")
        XCTAssertEqual(self.viewModel.alertButton, "Try again")
        XCTAssertEqual(self.viewModel.title, "Dessert List")
    }
    
    func testFetchListSuccess() async {
        let meal = Meal.init(idMeal: "", strMeal: "aaa", strMealThumb: "")
        let meal2 = Meal.init(idMeal: "", strMeal: "bbb", strMealThumb: "")
        let list = MealList.init(meals: [meal2, meal])
        
        self.viewModel = DessertListViewModel(dataProvider: MockObjectProviderSuccess(object: list))
        
        do {
            await viewModel.fetchList()
            XCTAssertFalse(self.viewModel.meals.isEmpty, "Fetched list should not be empty")
        }
    }
    
    func testFetchListFailure() async {
        self.viewModel = DessertListViewModel(dataProvider: MockObjectProviderError())
        
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
