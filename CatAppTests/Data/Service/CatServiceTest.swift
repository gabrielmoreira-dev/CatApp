@testable import CatApp
import XCTest

final class CatServiceTest: XCTestCase {
    private lazy var sut: CatService = {
        CatService(apiClient: apiClientSpy)
    }()

    private lazy var apiClientSpy: ApiClientSpy = {
        ApiClientSpy<[CatResponse]>()
    }()

    func testFetchData_WhenSuccess_ThenReturnData() async throws {
        apiClientSpy.successData = [CatResponse.dummy]
        let input = CatServiceInput(page: 0, limit: 1)

        let result = try await sut.fetchData(input: input)

        XCTAssertEqual(result, [CatResponse.dummy])
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
        apiClientSpy.successData = [.dummy]
        let page = 0
        let limit = 1
        let input = CatServiceInput(page: page, limit: limit)

        let _ = try await sut.fetchData(input: input)

        XCTAssertEqual(apiClientSpy.receivedEndpoint as? CatEndpoint, .catList(page: page, limit: limit))
    }
}
