import XCTest
@testable import DessertApp

class MealDetailsViewModelTests: XCTestCase {

    var viewModel: MealDetailsViewModel!

    override func setUpWithError() throws {
        viewModel = MealDetailsViewModel(id: "", dataProvider: MockObjectProviderError())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testViewTexts() {
        XCTAssertEqual(self.viewModel.title, "")
        XCTAssertEqual(self.viewModel.instructionsTitle, "Instructions")
        XCTAssertEqual(self.viewModel.ingredientsTitle, "Ingredients")
    }
    
    func testMeasureIngredientFormat() {
        let ingredient = "Plain Flour"
        let measure = "120g"
        
        let formattedText = self.viewModel.itemFormat(ingredient: ingredient, measure: measure)
        
        XCTAssertEqual(formattedText, "120g Plain Flour")
    }

    func testFetchDetailsSuccess() async {
        let dummyId = "53049"
        
        let meal = MealDetail()
        let meals = MealsDetails(meals: [meal])
        
        viewModel = MealDetailsViewModel(id: dummyId, dataProvider: MockObjectProviderSuccess(object: meals))
        
        do {
            await viewModel.fetchDetails()
            XCTAssertNotNil(self.viewModel.meal, "Object should not be nil")
        }
    }
    
    func testFetchFailure() async {
        let dummyId = "1111"
        self.viewModel = MealDetailsViewModel(id: dummyId, dataProvider: MockObjectProviderError())
        
        do {
            await viewModel.fetchDetails()
            XCTAssertNil(self.viewModel.meal, "Object should be nil")
        }
    }
    
    func testFetchEmptyArray() async {
        
        let meals = MealsDetails(meals: [])
        
        let dummyId = "1111"
        self.viewModel = MealDetailsViewModel(id: dummyId, dataProvider: MockObjectProviderSuccess(object: meals))
        
        do {
            await viewModel.fetchDetails()
        }
        
    }
    
    func testFetchDetails() {
        guard let fileURL = Bundle.main.url(forResource: "MealsDetails", withExtension: "json") else {
            XCTFail()
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: fileURL)
            let decoder = JSONDecoder()
            let meals = try decoder.decode(MealsDetails.self, from: jsonData)
            XCTAssertNotNil(meals)
        } catch {
            XCTFail()
        }
        
    }
    
}
