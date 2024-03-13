import XCTest
@testable import DessertApp


class CoordinatorTests: XCTestCase {
    
    var coordinator: Coordinator!
    
    override func setUp() {
        coordinator = Coordinator(provider: MockObjectProviderError())
    }
    
    override func tearDown() {
        coordinator = nil
    }
    
    func testGoToCategory() {
        XCTAssertTrue(coordinator.goToCategory() is CategoryView<CategoryViewModel>)
    }
    
    func testGoToList() {
        XCTAssertTrue(coordinator.goToMealList(category: "") is MealListView<MealListViewModel>)
    }
    
    func testGoToDetail() {
        XCTAssertTrue(coordinator.goToDetails(id: "") is MealDetailsView<MealDetailsViewModel>)
    }
    
}
