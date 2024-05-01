import Foundation

protocol GenerateObjectProviderProtocol {
    func fetchObject<T>(from request: URLRequest) async throws -> T where T : Decodable
}

class GenerateMealProvider { }

extension GenerateMealProvider: GenerateObjectProviderProtocol {
    func fetchObject<T>(from request: URLRequest) async throws -> T where T : Decodable {
        do {
            let (data, _)  = try await URLSession.shared.data(for: request)
            let generatedModel = try? JSONDecoder().decode(GenerateMealModel.self, from: data)
            let content = generatedModel?.choices.first?.message.content
            let jsonData = content?.data(using: .utf8)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData ?? Data(), options: []) as? [String: Any]
            let prettyPrintedData = try JSONSerialization.data(withJSONObject: jsonObject ?? (Any).self, options: .prettyPrinted)
            let object = try JSONDecoder().decode(T.self, from: prettyPrintedData)
            return object
        } catch {
             throw error
        }
    }
    
}


