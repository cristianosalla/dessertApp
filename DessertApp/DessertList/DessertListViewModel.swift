import SwiftUI

class DessertListViewModel: DessertListViewModelProtocol {
    @Published var meals: [Meal] = [Meal]()
    @Published var showAlert: Bool = false
    
    var alertText: String { "Couldn't load list of desserts." }
    var alertButton: String { "Try again" }
    var title: String { "Dessert List" }
    
    private var dataProvider: ObjectProviderProtocol
    private var url = Endpoint.list.url

    init(dataProvider: ObjectProviderProtocol = DataProvider()) {
        self.dataProvider = dataProvider
    }

    @MainActor
    func fetchList() async {
        do {
            let result: MealList = try await dataProvider.fetchObject(from: self.url)
            self.meals = result.meals.sorted{ $0.strMeal < $1.strMeal }
        } catch {
            self.showAlert = true
        }
    }
}
