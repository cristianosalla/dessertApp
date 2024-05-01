import Foundation

class GenerateMealProviderMock<O: Decodable>: GenerateObjectProviderProtocol {
    
    enum MockError: Error {
        case generic
    }
    
    var object: O
    
    init(object: O) {
        self.object = object
    }
    
    func fetchObject<T>(from request: URLRequest) async throws -> T where T : Decodable {
        guard let obj = object as? T else {
            throw MockError.generic
        }
        
        return obj
    }
    
}
