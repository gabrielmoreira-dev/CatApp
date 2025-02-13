import Foundation

final class URLSessionLocal: Codable {
    private let responses: [String: LocalResponse]

    init(responses: [String : LocalResponse]) {
        self.responses = responses
    }
}

extension URLSessionLocal: URLSessionType {
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        guard let url = request.url?.absoluteString,
              let response = responses[url] else {
            throw CatAppError.invalidURL
        }
        guard let data = response.data else {
            throw response.error
        }
        return (data, URLResponse())
    }
}
