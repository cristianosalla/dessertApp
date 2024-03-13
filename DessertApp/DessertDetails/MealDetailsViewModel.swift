import Foundation

class MealDetailsViewModel: MealDetailsViewModelProtocol {
    var title: String { return meal?.strMeal ?? "" }
    var instructionsTitle: String { "Instructions" }
    var ingredientsTitle: String { "Ingredients" }
    
    @Published var meal: MealDetail?
    
    @Published var showAlert = false
    
    let id: String
    private var dataProvider: ObjectProviderProtocol
    
    init(id: String, dataProvider: ObjectProviderProtocol = DataProvider()) {
        self.dataProvider = dataProvider
        self.id = id
    }
    
    @MainActor
    func fetchDetails() async {
        let id = self.id
        
        do {
            let result: MealsDetails = try await dataProvider.fetchObject(from: Endpoint.objectId(id).url)
            if let meal = result.meals.first {
                self.meal = meal
            } else {
                self.showAlert = true
            }
        } catch {
            self.showAlert = true
        }
    }
    
    func itemFormat(ingredient: String, measure: String) -> String {
        "• \(measure) \(ingredient)"
    }
    
}
