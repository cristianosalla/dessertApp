import Foundation

class GenerateMealViewModel: ObservableObject {
    
    @Published var meal: Recipe?
    
    let placeholderText = "Describe the meal you want"
    let buttonText = "Go"
    
    private var provider: GenerateObjectProviderProtocol
    
    init(provider: GenerateObjectProviderProtocol = GenerateMealProvider()) {
        self.provider = provider
    }
    
    @MainActor
    func getGeneratedMeal(_ message: String) async throws -> Recipe {
        do {
            let meal: Recipe = try await
            provider
                .fetchObject(
                    from: GenerateMealEndpoint
                        .chatCompletions(message)
                        .urlRequest)
            
            return meal
        }catch {
            throw error
        }
    }
    
}
