import XCTest
@testable import DessertApp


class CoordinatorTests: XCTestCase {
    
    var coordinator: Coordinator!
    
    override func setUp() {
        coordinator = Coordinator()
    }
    
    override func tearDown() {
        coordinator = nil
    }
    
    func testGoToCategory() {
        guard coordinator.goToCategory() is CategoryView<CategoryViewModel> else {
            XCTFail()
            return
        }
    }
    
    func testGoToList() {
        guard coordinator.goToMealList(category: "") is MealListView<MealListViewModel> else {
            XCTFail()
            return
        }
    }
    
    func testGoToDetail() {
        guard coordinator.goToDetails(id: "") is MealDetailsView<MealDetailsViewModel> else {
            XCTFail()
            return
        }
    }
    
}
