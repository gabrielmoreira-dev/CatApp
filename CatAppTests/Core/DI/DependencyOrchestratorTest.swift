@testable import CatApp
import XCTest

final class DependencyOrchestratorTest: XCTestCase {
    private lazy var sut: DependencyOrchestrator = {
        .shared
    }()

    override func setUp() {
        super.setUp()
        DependencyOrchestrator.registerDependencies()
    }

    func testResolveDependency_WhenIsURLSession_ThenResolveSuccessfully() {
        let dependency: URLSessionType = sut.resolve()
        XCTAssertNotNil(dependency)
    }

    func testResolveDependency_WhenIsApiClient_ThenResolveSuccessfully() {
        let dependency: ApiClientType = sut.resolve()
        XCTAssertNotNil(dependency)
    }
}
