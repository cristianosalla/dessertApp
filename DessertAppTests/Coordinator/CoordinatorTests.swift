import XCTest
@testable import DessertApp


@available(iOS 17.0, *)
class CoordinatorTests: XCTestCase {
    
    var coordinator: Coordinator!
    
    override func setUp() {
        coordinator = Coordinator(objectProvider: MockObjectProviderError())
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
