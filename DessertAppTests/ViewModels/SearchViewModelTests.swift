import XCTest
@testable import DessertApp

class SearchViewModelTests: XCTestCase {
    
    var viewModel: SearchViewModel!
    
    override func setUpWithError() throws {
        viewModel = SearchViewModel(dataProvider: MockObjectProviderError())
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testViewTexts() {
        XCTAssertEqual(self.viewModel.title, "Search List")
    }
    
    func testSearchSuccess() async {
        let meal = Meal(idMeal: "", strMeal: "aaa", strMealThumb: "")
        let meal2 = Meal(idMeal: "", strMeal: "bbb", strMealThumb: "")
        let list = MealList(meals: [meal2, meal])
        
        self.viewModel = SearchViewModel(dataProvider: MockObjectProviderSuccess(object: list))
        
        do {
            await viewModel.fetchMeals("")
            XCTAssertFalse(self.viewModel.searchedMeals.isEmpty, "Fetched list should not be empty")
        }
    }
    
    func testSetSearchEmpty() {
        let meal = Meal(idMeal: "", strMeal: "aaa", strMealThumb: "")
        let meal2 = Meal(idMeal: "", strMeal: "bbb", strMealThumb: "")
        let list = MealList(meals: [meal2, meal])
        
        viewModel = SearchViewModel(dataProvider: MockObjectProviderSuccess(object: list))
        viewModel.searchedMeals = [meal, meal2]
        XCTAssertNotNil(viewModel.searchedMeals.isEmpty)
        
        viewModel.searchText = ""
        viewModel.setSearch()
        XCTAssertTrue(viewModel.searchedMeals.isEmpty)
    }
    
    func testTimerExecution() {
        let expectation = expectation(description: "execute timer")
        let timerExecution = {
            expectation.fulfill()
        }
        
        viewModel = SearchViewModel(dataProvider: MockObjectProviderError(), timerExecution: timerExecution)
        viewModel.searchText = "Chicken"
        wait(for: [expectation], timeout: 3)
    }
}
