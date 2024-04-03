import Foundation

class MealDetailsViewModel: MealDetailsViewModelProtocol {
    
    var title: String { return meal?.strMeal ?? "" }
    var instructionsTitle: String { "Instructions" }
    var ingredientsTitle: String { "Ingredients" }
    
    @Published var meal: MealDetail?
    @Published var showVideo: Bool = false
    @Published var showTimer: Bool = false
    
    let id: String
    private var dataProvider: ObjectProviderProtocol
    
    init(id: String, dataProvider: ObjectProviderProtocol = DataProvider()) {
        self.dataProvider = dataProvider
        self.id = id
    }
    
    @MainActor
    func fetchDetails() async {
        let id = self.id
        let url = Endpoint.objectId(id).url
        
        if let result: MealsDetails = try? await dataProvider.fetchObject(from: url) {
            self.meal = result.meals.first
            if let youtube = self.meal?.strYoutube, !youtube.isEmpty {
                showVideo = true
            }
        }
    }
    
    func itemFormat(ingredient: String, measure: String) -> String {
        "\(measure) \(ingredient)"
    }
    
    func timerButtonText() -> String {
        return showTimer ? "Hide Timer" : "Set Timer"
    }
    
}
