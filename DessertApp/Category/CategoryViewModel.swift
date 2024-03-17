import Foundation

class CategoryViewModel: CategoryViewModelProtocol{
    
    @Published var showAlert: Bool = false
    
    @Published var categories: [Categories] = []
    @Published var searchedMeals: [Meal] = []
    
    var title: String { "Category List" }
    
    var dataProvider: ObjectProviderProtocol
    
    init(dataProvider: ObjectProviderProtocol = DataProvider()) {
        self.dataProvider = dataProvider
    }
    
    @MainActor
    func fetchList() async {
        do {
            let result: Category = try await dataProvider.fetchObject(from: Endpoint.category.url)
            self.categories = result.categories
        } catch {
            self.showAlert = true
        }
    }
    
}
