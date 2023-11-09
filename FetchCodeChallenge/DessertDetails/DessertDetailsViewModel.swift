//
//  DessertDetailsViewModel.swift
//  FetchCodeChallenge
//
//  Created by Cristiano Salla Lunardi on 11/1/23.
//

import Foundation

class DessertDetailsViewModel: ObservableObject {
    @Published var title = ""
    @Published var instructions = ""
    @Published var url = URL(string: "")
    @Published var ingredientsAndMeasures = [IngredientMeasure]()
    
    @Published var showAlert = false
    
    let errorAlertText = "Couldn't load dessert details."
    let errorAlertButton = "Try again"
    
    let instructionsTitle = "Instructions"
    let ingredientsTitle = "Ingredients"
    
    private var dataProvider: ObjectProviderProtocol

    init(dataProvider: ObjectProviderProtocol = DataProvider()) {
        self.dataProvider = dataProvider
    }
    
    func fetchDetails(id: String) {
        dataProvider.fetchObject(from: DataProvider.Endpoint.objectId(id).url) { [weak self] (result: Result<MealsDetails, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let mealDetails):
                    guard let meal = mealDetails.meals.first else {
                        self?.showAlert = true
                        return
                    }
                    
                    self?.setDetails(meal: meal)
                case .failure(_):
                    self?.showAlert = true
                }
            }
        }
    }
    
    func setDetails(meal: MealDetail) {
        self.url = URL(string: meal.strMealThumb)
        self.title = meal.strMeal
        self.instructions = meal.strInstructions
        self.ingredientsAndMeasures = meal.ingredientMeasure
    }
    
    
    func ingredientMeasureFormat(ingredient: String, measure: String) -> String {
        "• \(measure) \(ingredient)"
    }
    
}
