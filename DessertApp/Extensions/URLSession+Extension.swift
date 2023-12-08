import Foundation

protocol HTTPClient {
    func get(url: URL) async -> Result<Data, Error>
}

extension URLSession: HTTPClient {
    func get(url: URL) async -> Result<Data, Error> {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return .success(data)
        } catch {
            return .failure(error)
        }
    }
}
