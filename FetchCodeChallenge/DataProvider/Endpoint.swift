//
//  CocktailEndpoint.swift
//  FetchCodeChallenge
//
//  Created by Cristiano Salla Lunardi on 11/17/23.
//

import Foundation

enum Endpoint {
    case list
    case objectId(String)
    
    private var fullPath: String {
        var endpoint: String
        switch self {
        case .list:
            endpoint = "/filter.php?c=Dessert"
        case .objectId(let id):
            endpoint = "/lookup.php?i=\(id)"
        }
        let baseURL: String = "https://themealdb.com/api/json/v1/1"
        return baseURL + endpoint
    }
    
    var url: URL {
        guard let url = URL(string: fullPath) else {
            preconditionFailure("The url used in \(self.self) is not valid")
        }
        return url
    }
}


