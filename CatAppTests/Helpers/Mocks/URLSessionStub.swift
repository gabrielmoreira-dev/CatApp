@testable import CatApp
import Foundation

final class URLSessionStub: URLSessionType {
    var successData: Data?
    var error: Error = CatAppError.generic
    
    func data(for request: URLRequest, delegate: (any URLSessionTaskDelegate)?) async throws -> (Data, URLResponse) {
        guard let successData else { throw error }
        return (successData, URLResponse())
    }
}
