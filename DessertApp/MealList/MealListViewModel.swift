import SwiftUI

class MealListViewModel: ObservableObject {
    @Published var meals: [Meal] = [Meal]()
    @Published var showAlert: Bool = false
    
    var title: String
    
    private var dataProvider: ObjectProviderProtocol
    private var url: URL

    init(category: String, dataProvider: ObjectProviderProtocol = DataProvider()) {
        self.url = Endpoint.list(category).url
        self.dataProvider = dataProvider
        self.title = category + " List"
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
