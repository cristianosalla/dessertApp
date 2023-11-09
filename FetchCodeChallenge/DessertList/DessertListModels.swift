//
//  DessertListModels.swift
//  FetchCodeChallenge
//
//  Created by Cristiano Salla Lunardi on 11/7/23.
//

import Foundation

struct MealList: Codable {
    let meals: [Meal]
}

struct Meal: Codable, Hashable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
}
