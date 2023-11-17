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
    
    func fetchDetails(id: String, completion: (() -> ())? = nil) {
        Task {
            let result: Result<MealsDetails, Error> = await dataProvider.fetchObject(from: DataProvider.Endpoint.objectId(id).url)
            DispatchQueue.main.async {
                switch result {
                case .success(let mealDetails):
                    if let meal = mealDetails.meals.first {
                        self.meal = meal
                    } else {
                        self.showAlert = true
                    }
                case .failure(_):
                    self.showAlert = true
                }
                completion?()
            }
        }
    }
    
    func ingredientMeasureFormat(ingredient: String, measure: String) -> String {
        "• \(measure) \(ingredient)"
    }
    
}
