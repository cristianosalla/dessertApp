import Foundation

struct GenerateMealModel: Codable {
    let created: Int
    let choices: [Choice]
    let model: String
}

struct Choice: Codable {
    let message: Message
}

struct Message: Codable {
    let content, role: String
}

struct Recipe: Codable, Hashable {
    let title: String
    let ingredients: [String]
    let instructions: [String]
}
