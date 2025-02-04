import Foundation

protocol ApiClientType {
    func fetchData<T: Decodable>(from endpoint: EndpointType) async throws -> T
}

final class ApiClient: ApiClientType {
    private let session: URLSessionType
    
    init(session: URLSessionType = URLSession.shared) {
        self.session = session
    }
    
    func fetchData<T: Decodable>(from endpoint: EndpointType) async throws -> T {
        guard let url = getURL(for: endpoint) else {
            throw CatAppError.invalidURL
        }
        var request = URLRequest(url: url)
        request.addValue(Environment.apiKey.value, forHTTPHeaderField: Headers.apiKey.rawValue)
        request.httpMethod = endpoint.method.rawValue
        let (data, _) = try await session.data(for: request, delegate: nil)
        return try parse(data)
    }
    
    private func getURL(for endpoint: EndpointType) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Environment.baseURL.value
        components.path = endpoint.path
        components.queryItems = endpoint.queryItems
        return components.url
    }
    
    private func parse<T: Decodable>(_ data: Data) throws -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(T.self, from: data)
    }
}
