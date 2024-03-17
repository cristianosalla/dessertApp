import Foundation

class SearchViewModel: SearchViewModelProtocol {
    var title: String = "Search List"
    
    private var timer: Timer?
    @Published var searchText: String  = "" { didSet { setSearch() } }
    
    @Published var searchedMeals: [Meal] = []
    
    private var dataProvider: ObjectProviderProtocol
    
    init(dataProvider: ObjectProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    @MainActor
    func fetchMeals(_ search: String) async {
        do {
            let result: MealList = try await dataProvider.fetchObject(from: Endpoint.search(search).url)
            self.searchedMeals = result.meals
        } catch { }
    }
    
    func setSearch() {
        timer?.invalidate()
        
        if searchText.isEmpty {
            self.searchedMeals = []
            return
        }
    
        if searchText.count > 3 {
            timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { _ in
                Task {
                    await self.fetchMeals(self.searchText)
                }
            })
        }
    }
    
}
