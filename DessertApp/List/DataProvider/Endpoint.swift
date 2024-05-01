import Foundation

enum Endpoint {
    case list(String)
    case objectId(String)
    case category
    case search(String)
    
    private var fullPath: String {
        var endpoint: String
        switch self {
        case .search(let search):
            endpoint = "/search.php?s=\(search)"
        case .category:
            endpoint = "/categories.php"
        case .list(let category):
            endpoint = "/filter.php?c=\(category)"
        case .objectId(let id):
            endpoint = "/lookup.php?i=\(id)"
        }
        let baseURL: String = "https://themealdb.com/api/json/v1/1"
        return baseURL + endpoint
    }
    
    var url: URL {
        guard let url = URL(string: fullPath) else {
            preconditionFailure("The url used in \(self.self) is not valid")
        }
        return url
    }
}


