import Foundation

class News: Codable {
    var status: String
    var totalResults: Int
    var articles: [Article]
    
}
