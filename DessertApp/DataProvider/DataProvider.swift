import Foundation

protocol ImageProviderProtocol {
    func fetchImageData(thumbnailURLString: String) async throws -> Data
}

protocol ObjectProviderProtocol {
    func fetchObject<T: Decodable>(from endpoint: URL) async throws -> T
}

// MARK: - Data Provider

class DataProvider {
    
    var httpClient: HTTPClient
    
    private var cache = NSCache<AnyObject, AnyObject>()
    
    init(httpClient: HTTPClient = URLSession.shared) {
        self.httpClient = httpClient
    }
    
    enum DataProviderError: Error {
        case noData
        case url
        case decode
    }
}

// MARK: - Object Provider Protocol

extension DataProvider: ObjectProviderProtocol {
    
    func fetchObject<T: Decodable>(from endpoint: URL) async throws -> T {
        let result = try await httpClient.get(url: endpoint)
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: result)
            return decoded
        } catch {
            throw DataProviderError.decode
        }
    }
}

// MARK: - Image Provider Protocol

extension DataProvider: ImageProviderProtocol {
    
    func fetchImageData(thumbnailURLString: String) async throws -> Data {
        guard let url = URL(string: thumbnailURLString) else {
            throw DataProviderError.url
        }
        
        if let cachedObject = cache.object(forKey: url as AnyObject),
            let data = cachedObject as? Data {
            return data
        }
        
        do {
            let result = try await httpClient.get(url: url)
            cache.setObject(result as AnyObject, forKey: url as AnyObject)
            return result
        } catch(let error) {
            throw error
        }
    }
}

