@testable import CatApp
import XCTest

final class DependencyContainerStub: HasURLSession, HasApiClient {
    lazy var session: URLSessionType = {
        URLSessionStub()
    }()

    var sessionStub: URLSessionStub? {
        session as? URLSessionStub
    }

    lazy var apiClient: ApiClientType = {
        ApiClientSpy()
    }()

    var apiClientSpy: ApiClientSpy? {
        apiClient as? ApiClientSpy
    }
}
