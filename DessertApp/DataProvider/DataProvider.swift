import Foundation

protocol ImageProviderProtocol {
    func fetchImageData(thumbnailURLString: String) async -> Result<Data, Error>
}

protocol ObjectProviderProtocol {
    func fetchObject<T: Decodable>(from endpoint: URL) async -> Result<T, Error>
}

// MARK: - Data Provider

class DataProvider {
    
    var httpClient: HTTPClient
    
    init(httpClient: HTTPClient = URLSession.shared) {
        self.httpClient = httpClient
    }
    
    enum DataProviderError: Error {
        case noData
        case url
    }
}

// MARK: - Object Provider Protocol

extension DataProvider: ObjectProviderProtocol {
    
    func fetchObject<T: Decodable>(from endpoint: URL) async -> Result<T, Error>  {
        let result = await httpClient.get(url: endpoint)
        switch result {
        case .success(let data):
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                return .success(decoded)
            } catch(let error) {
                return .failure(error)
            }
        case .failure(let error):
            return .failure(error)
        }
    }
}

// MARK: - Image Provider Protocol

extension DataProvider: ImageProviderProtocol {
    
    func fetchImageData(thumbnailURLString: String) async -> Result<Data, Error> {
        guard let url = URL(string: thumbnailURLString) else {
            return .failure(DataProviderError.url)
        }
        
        let result = await httpClient.get(url: url)
        switch result {
        case .success(let data):
            return .success(data)
        case .failure(let error):
            return .failure(error)
        }
    }
}

