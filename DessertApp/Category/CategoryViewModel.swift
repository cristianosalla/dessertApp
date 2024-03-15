import Foundation

class CategoryViewModel: CategoryViewModelProtocol{
    
    @Published var showAlert: Bool = false
    
    @Published var categories: [Categories] = []
    @Published var searchedMeals: [Meal] = []
    
    
    private var timer: Timer?
    
    @Published var searchText: String = "" {
        didSet {
            timer?.invalidate()
            if searchText.isEmpty {
                self.searchedMeals = []
            } else {
                if searchText.count > 3 {
                    timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
                        Task {
                            await self.fetchMeals(self.searchText)
                        }
                    })
                }
            }
        }
    }
    
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
    
    @MainActor
    func fetchMeals(_ search: String) async {
        do {
            let result: MealList = try await dataProvider.fetchObject(from: Endpoint.search(search).url)
            self.searchedMeals = result.meals
        } catch {
            self.showAlert = true
        }
    }
}
