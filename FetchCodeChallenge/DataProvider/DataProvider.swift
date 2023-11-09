//
//  DataProvider.swift
//  FetchCodeChallenge
//
//  Created by Cristiano Salla Lunardi on 11/1/23.
//

import Foundation

protocol ImageProviderProtocol {
    func fetchImageData(thumbnailURLString: String, completion: @escaping (Result<Data, Error>) -> Void)
}

protocol ObjectProviderProtocol {
    func fetchObject<T: Decodable>(from endpoint: URL, completion: @escaping (Result<T, Error>) -> Void)
}

// MARK: - Data Provider

class DataProvider {
    
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
                preconditionFailure("The url used in \(Endpoint.self) is not valid")
            }
            return url
        }
    }
    
    enum DataProviderError: Error {
        case noData
        case url
    }
}

// MARK: - Object Provider Protocol

extension DataProvider: ObjectProviderProtocol {
    
    func fetchObject<T: Decodable>(from endpoint: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: endpoint) { data, response, error in
            if let error {
                completion(.failure(error))
            } else {
                guard let data else {
                    completion(.failure(DataProviderError.noData))
                    return
                }
                
                
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch(let error) {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

// MARK: - Image Provider Protocol

extension DataProvider: ImageProviderProtocol {
    
    func fetchImageData(thumbnailURLString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: thumbnailURLString) else {
            completion(.failure(DataProviderError.url))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error {
                completion(.failure(error))
            } else {
                guard let data else {
                    completion(.failure(DataProviderError.noData))
                    return
                }
                
                completion(.success(data))
            }
        }.resume()
    }
}

