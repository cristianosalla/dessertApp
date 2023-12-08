import Foundation

class DessertDetailsViewModel: ObservableObject {
    
    @Published var meal: MealDetail?
    
    @Published var showAlert = false
    
    let id: String
    
    let errorAlertText = "Couldn't load dessert details."
    let errorAlertButton = "Try again"
    
    let instructionsTitle = "Instructions"
    let ingredientsTitle = "Ingredients"
    
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
