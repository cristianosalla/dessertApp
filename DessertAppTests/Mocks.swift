@testable import DessertApp
import Foundation

struct MockHttpClientSuccess<T: Encodable>: HTTPClient {
    
    var data: Data
    
    init(object: T) {
        do {
            self.data = try JSONEncoder().encode(object)
        } catch {
            self.data = Data()
        }
    }
    
    init(data: Data) {
        self.data = data
    }
    
    func get(url: URL) async -> Result<Data, Error> {
        return .success(data)
    }
}

struct MockHttpClientError: HTTPClient {
    func get(url: URL) async -> Result<Data, Error> {
        return .failure(DataProvider.DataProviderError.noData)
    }
}


struct MockObjectProviderSuccess<D: Decodable>: ObjectProviderProtocol {
    
    var object: D
    
    init(object: D) {
        self.object = object
    }
    
    func fetchObject<T>(from endpoint: URL) async -> Result<T, Error> where T : Decodable {
        if let obj = self.object as? T {
            return .success(obj)
        } else {
            return .failure(DataProvider.DataProviderError.noData)
        }
    }
}

struct MockObjectProviderError: ObjectProviderProtocol {
    func fetchObject<T>(from endpoint: URL) async -> Result<T, Error> where T : Decodable {
        return .failure(DataProvider.DataProviderError.noData)
    }
}

struct MockImageProviderSuccess: ImageProviderProtocol {
    func fetchImageData(thumbnailURLString: String) async -> Result<Data, Error> {
        return .success(Data())
    }
}

struct MockImageProviderError: ImageProviderProtocol {
    func fetchImageData(thumbnailURLString: String) async -> Result<Data, Error> {
        return .failure(DataProvider.DataProviderError.noData)
    }
}
