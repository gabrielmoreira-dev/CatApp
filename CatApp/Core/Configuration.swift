import Foundation

enum Configuration: String {
    case baseURL = "BASE_URL"
    case apiKey = "API_KEY"
    
    var value: String {
        guard let property = Bundle.main.object(forInfoDictionaryKey: rawValue) as? String else {
            fatalError("Property not found: \(rawValue)")
        }
        return property
    }
}
