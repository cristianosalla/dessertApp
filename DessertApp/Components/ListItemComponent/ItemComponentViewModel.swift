import SwiftUI

class ItemComponentViewModel: ItemComponentViewModelProtocol {
    
    var url: String
    var text: String
    
    private var dataProvider: ImageProviderProtocol
    
    init(url: String, text: String, dataProvider: ImageProviderProtocol = DataProvider()) {
        self.url = url
        self.text = text
        self.dataProvider = dataProvider
    }
    
    func getThumb() async throws -> Data {
        let result = try await dataProvider.fetchImageData(thumbnailURLString: url)
        return result
    }
}
