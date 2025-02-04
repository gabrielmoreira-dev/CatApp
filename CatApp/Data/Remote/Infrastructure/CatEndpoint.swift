import Foundation

enum CatEndpoint: EndpointType {
    case catList(page: Int, limit: Int)
    
    var path: String {
        switch self {
        case .catList:
            return "/v1/images/search"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .catList:
            return .get
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case let .catList(page, limit):
            return [
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "limit", value: String(limit)),
                URLQueryItem(name: "order", value: "DESC"),
                URLQueryItem(name: "has_breeds", value: String(true))
            ]
        }
    }
}
