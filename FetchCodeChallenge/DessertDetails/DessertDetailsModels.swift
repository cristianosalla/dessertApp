//
//  MealModel.swift
//  FetchCodeChallenge
//
//  Created by Cristiano Salla Lunardi on 11/1/23.
//

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

    var ingredientMeasure: [IngredientMeasure] = []

    private enum CodingKeys: CodingKey {
        case strIngredient(index: Int)
        case strMeasure(index: Int)
        
        case idMeal, strMeal, strInstructions, strMealThumb, none
        
        var intValue: Int? {
            return nil
        }
        
        var stringValue: String {
            switch self {
            case .idMeal:
                return "idMeal"
            case .strMeal:
                return "strMeal"
            case .strInstructions:
                return "strInstructions"
            case .strMealThumb:
                return "strMealThumb"
            case .strIngredient(let index):
                return "strIngredient\(index)"
            case .strMeasure(let index):
                return "strMeasure\(index)"
            default:
                return ""
            }
        }
        
        init?(stringValue: String) {
            if stringValue.starts(with: "strIngredient") {
                if let index = Int(stringValue.dropFirst("strIngredient".count)) {
                    self = .strIngredient(index: index)
                    return
                }
            } else if stringValue.starts(with: "strMeasure") {
                if let index = Int(stringValue.dropFirst("strMeasure".count)) {
                    self = .strMeasure(index: index)
                    return
                }
            } else {
                self = .init(stringValue: stringValue) ?? .none
                return
            }
            
            return nil
        }
       
        init?(intValue: Int) {
            return nil
        }
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        idMeal = try container.decode(String.self, forKey: .idMeal)
        strMeal = try container.decode(String.self, forKey: .strMeal)
        strInstructions = try container.decode(String.self, forKey: .strInstructions)
        strMealThumb = try container.decode(String.self, forKey: .strMealThumb)
        
        let APIStartingIndex = 1
        for index in APIStartingIndex... {
            if let ingredient = try? container.decode(String.self, forKey: .strIngredient(index: index)),
               let measure = try? container.decode(String.self, forKey: .strMeasure(index: index)),
               !ingredient.isEmpty,
               !measure.isEmpty {
                ingredientMeasure.append(IngredientMeasure(ingredient: ingredient, measure: measure))
            } else {
                break
            }
        }
    }
    
    func encode(to encoder: Encoder) throws { }
}
