import Foundation

struct MealsDetails: Codable {
    let meals: [MealDetail]
}

struct IngredientMeasure: Codable, Equatable, Hashable {
    let ingredient: String
    let measure: String
}

struct MealDetail: Codable, Equatable {
    var idMeal: String
    var strMeal: String
    var strInstructions: String
    var strMealThumb: String

    var items: [Item] = []
    
    struct Item: Codable, Equatable, Hashable {
        let ingredient: String
        let measure: String
    }
    
    init() {
        self.idMeal = ""
        self.strMeal = ""
        self.strInstructions = ""
        self.strMealThumb = ""
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        let mealDict = try container.decode([String: String?].self)
      
        idMeal = (mealDict["idMeal"] ?? "") ?? ""
        strMeal = (mealDict["strMeal"] ?? "") ?? ""
        strInstructions = (mealDict["strInstructions"] ?? "") ?? ""
        strMealThumb = (mealDict["strMealThumb"] ?? "") ?? ""
        
        var index = 1
        var items = [Item]()
        
        while let ingredient = mealDict["strIngredient\(index)"] as? String,
              let measure = mealDict["strMeasure\(index)"] as? String,
              !ingredient.isEmpty,
              !measure.isEmpty {
            items.append(Item(ingredient: ingredient, measure: measure))
            index += 1
        }
        
        self.items = items
    }
}
