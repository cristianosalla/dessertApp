import Foundation

struct Category: Codable {
    let categories: [Categories]
}

struct Categories: Codable, Hashable {
    let idCategory: String
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
