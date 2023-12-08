import Foundation

protocol HTTPClient {
    func get(url: URL) async throws -> Data
}

extension URLSession: HTTPClient {
    func get(url: URL) async throws -> Data {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            throw error
        }
    }
}
