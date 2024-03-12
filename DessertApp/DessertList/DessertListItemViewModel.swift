import SwiftUI

class DessertListItemViewModel: DessertListItemViewModelProtocol {
    
    var url: String
    var meal: String
    
    private var dataProvider: ImageProviderProtocol
    
    init(url: String, meal: String, dataProvider: ImageProviderProtocol = DataProvider()) {
        self.url = url
        self.meal = meal
        self.dataProvider = dataProvider
    }
    
    func getThumb() async throws -> Data {
        let result = try await dataProvider.fetchImageData(thumbnailURLString: url)
        return result
    }
}

