//
//  DessertListViewModel.swift
//  FetchCodeChallenge
//
//  Created by Cristiano Salla Lunardi on 11/1/23.
//

import SwiftUI

class DessertListItemViewModel: ObservableObject {
    
    @Published var imageData: Data?
    
    var url: String
    var meal: String
    
    private var dataProvider: ImageProviderProtocol
    
    init(url: String, meal: String, dataProvider: ImageProviderProtocol = DataProvider()) {
        self.url = url
        self.meal = meal
        self.dataProvider = dataProvider
    }
    
    func getThumb(completion: @escaping (Data?) -> Void) {
        dataProvider.fetchImageData(thumbnailURLString: self.url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    completion(data)
                case .failure(_):
                    completion(nil)
                }
            }
        }
    }
}

