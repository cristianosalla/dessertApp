import Foundation

struct MealList: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Hashable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}
