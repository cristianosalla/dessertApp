//
//  DessertDetailsViewModel.swift
//  FetchCodeChallenge
//
//  Created by Cristiano Salla Lunardi on 11/1/23.
//

import Foundation

class DessertDetailsViewModel: ObservableObject {
    
    @Published var meal: MealDetail?
    
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
        Task {
            let result: Result<MealsDetails, Error> = await dataProvider.fetchObject(from: DataProvider.Endpoint.objectId(id).url)
            DispatchQueue.main.async {
                switch result {
                case .success(let mealDetails):
                    guard let meal = mealDetails.meals.first else {
                        self.showAlert = true
                        return
                    }
                    
                    self.meal = meal
                case .failure(_):
                    self.showAlert = true
                }
            }
        }
    }
    
    func ingredientMeasureFormat(ingredient: String, measure: String) -> String {
        "• \(measure) \(ingredient)"
    }
    
}
