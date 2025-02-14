import Foundation

protocol ApiClientType {
    func fetchData<T: Decodable>(from endpoint: EndpointType) async throws -> T
}

final class ApiClient: ApiClientType {
    private let dependencies: HasURLSession

    init(dependencies: HasURLSession = DependencyContainer()) {
        self.dependencies = dependencies
    }

    func fetchData<T: Decodable>(from endpoint: EndpointType) async throws -> T {
        guard let url = getURL(for: endpoint) else {
            throw CatAppError.invalidURL
        }
        var request = URLRequest(url: url)
        request.addValue(Configuration.apiKey.value, forHTTPHeaderField: Headers.apiKey.rawValue)
        request.httpMethod = endpoint.method.rawValue
        do {
            let (data, _) = try await dependencies.session.data(for: request, delegate: nil)
            return try parse(data)
        } catch {
            guard (error as? URLError)?.isInternetError == true else {
                throw error
            }
            throw CatAppError.internet
        }
    }
    
    private func getURL(for endpoint: EndpointType) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Configuration.baseURL.value
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

extension URLError {
    var isInternetError: Bool {
        let codes = [
            NSURLErrorBadURL,
            NSURLErrorTimedOut,
            NSURLErrorCannotFindHost,
            NSURLErrorCannotConnectToHost,
            NSURLErrorNetworkConnectionLost,
            NSURLErrorNotConnectedToInternet
        ]
        return codes.contains(code.rawValue)
    }
}
