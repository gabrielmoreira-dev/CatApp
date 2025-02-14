@testable import CatApp
import XCTest

final class CatServiceTest: XCTestCase {
    private lazy var sut: CatService = {
        CatService(dependencies: dependencies)
    }()

    private lazy var dependencies: DependencyContainerStub = {
        DependencyContainerStub()
    }()

    func testFetchData_WhenSuccess_ThenReturnData() async throws {
        dependencies.apiClientSpy?.successData = [CatResponse.dummy]
        let input = CatServiceInput(page: 0, limit: 1)

        let result = try await sut.fetchData(input: input)

        XCTAssertEqual(result, [.dummy])
    }

    func testFetchData_WhenFailure_ThenThrowError() async {
        let input = CatServiceInput(page: 0, limit: 1)
        var expectedError: Error?

        do {
            let _ = try await sut.fetchData(input: input)
        } catch {
            expectedError = error
        }

        XCTAssertNotNil(expectedError)
    }

    func testFetchData_WhenCalled_ThenPassEndpoint() async throws {
        dependencies.apiClientSpy?.successData = [CatResponse.dummy]
        let page = 0
        let limit = 1
        let input = CatServiceInput(page: page, limit: limit)

        let _ = try await sut.fetchData(input: input)

        XCTAssertEqual(dependencies.apiClientSpy?.receivedEndpoint as? CatEndpoint, .catList(page: page, limit: limit))
    }
}
