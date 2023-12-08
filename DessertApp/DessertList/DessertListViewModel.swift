import SwiftUI

class DessertListViewModel: ObservableObject {
    
    @Published var meals = [Meal]()
    
    @Published var showAlert = false
    
    let alertText = "Couldn't load list of desserts."
    let alertButton = "Try again"
    
    let title = "Dessert List"
    
    private var dataProvider: ObjectProviderProtocol
    
    init(dataProvider: ObjectProviderProtocol = DataProvider()) {
        self.dataProvider = dataProvider
    }
    
    @MainActor
    func fetchList(_ url: URL = Endpoint.list.url) async {
        do {
            let result: MealList = try await dataProvider.fetchObject(from: url)
            self.meals = result.meals.sorted{ $0.strMeal < $1.strMeal }
        } catch {
            self.showAlert = true
        }
    }
}

