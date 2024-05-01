import Foundation

enum GenerateMealEndpoint {
    case chatCompletions(String)
    case imageGeneration(String)
    
    private var apiKey: String {
        return ""
    }
    
    private var fullPath: (String, [String: Any]) {
        var endpoint: String
        var parameters: [String: Any]
        
        switch self {
        case .chatCompletions(let msg):
            endpoint = "/chat/completions"
            let messages = [
                ["content": "\(msg)", "role": "user"],
                ["content": "You give complete recipes of meals in json format with fields: title: String, instructions: Array<String> and ingredients: Array<String>", "role": "system"]
            ]
            
            let responseFormat = ["type": "json_object"]
            
            parameters = [
                "response_format" : responseFormat,
                "model": "gpt-3.5-turbo",
                "messages" : messages,
                "max_tokens": 500
            ]
            
            
        case .imageGeneration(let msg):
            endpoint = "/images/generations"
            
            parameters = [
                "model": "dall-e-3",
                "prompt" : msg,
                "n": 1,
                "size": "1024x1024"
            ]
        }
        
        let baseURL: String = "https://api.openai.com/v1"
        return (baseURL + endpoint, parameters)
    }
    
    var url: URL {
        guard let url = URL(string: fullPath.0) else {
            preconditionFailure("The url used in \(self.self) is not valid")
        }
        return url
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let httpBody = try? JSONSerialization.data(withJSONObject: fullPath.1)
        request.httpBody = httpBody
        
        return request
    }
}
