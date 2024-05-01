import Foundation

class GenerateMealDetailsViewModel: ObservableObject {
    
    var instructionsTitle: String { "Instructions" }
    var ingredientsTitle: String { "Ingredients" }
    var title: String
    
    @Published var meal: Recipe?
    @Published var showVideo: Bool = false
    @Published var showTimer: Bool = false
    
    init(meal: Recipe?) {
        self.meal = meal
        self.title = meal?.title ?? ""
    }
    
    func itemFormat(ingredient: String, measure: String) -> String {
        "\(measure) \(ingredient)"
    }
    
    func timerButtonText() -> String {
        return showTimer ? "Hide Timer" : "Set Timer"
    }
    
}
