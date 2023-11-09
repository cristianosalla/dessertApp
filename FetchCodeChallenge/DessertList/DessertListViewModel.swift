//
//  DessertListViewModel.swift
//  FetchCodeChallenge
//
//  Created by Cristiano Salla Lunardi on 11/1/23.
//

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
        fetchList()
    }
    
    func fetchList(_ url: URL = DataProvider.Endpoint.list.url) {
        dataProvider.fetchObject(from: url) { [weak self] (result: Result<MealList, Error>) in
            DispatchQueue.main.async {
                switch result {
                case .success(let meal):
                    self?.meals = meal.meals.sorted{ $0.strMeal < $1.strMeal }
                case .failure(_):
                    self?.showAlert = true
                }
            }
        }
    }
}

