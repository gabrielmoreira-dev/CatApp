@testable import CatApp
import XCTest

final class CatRepositoryTest: XCTestCase {
    private lazy var sut: CatRepository = {
        CatRepository(service: serviceSpy)
    }()

    private lazy var serviceSpy: CatServiceSpy = {
        CatServiceSpy()
    }()

    func testGetCatItems_WhenSuccess_ThenReturnItems() async throws {
        serviceSpy.successData = [CatResponse.dummy]

        let result = try await sut.getCatItems(page: 0, limit: 1)

        XCTAssertEqual(result, [CatItem.dummy])
    }

    func testGetCatItems_WhenFailure_ThenThrowError() async {
        var expectedError: Error?

        do {
            let _ = try await sut.getCatItems(page: 0, limit: 1)
        } catch {
            expectedError = error
        }

        XCTAssertNotNil(expectedError)
    }

    func testGetCatItems_WhenCalled_ThenPassParams() async throws {
        serviceSpy.successData = [CatResponse.dummy]
        let page = 0
        let limit = 1

        let result = try await sut.getCatItems(page: page, limit: limit)

        XCTAssertEqual(serviceSpy.receivedInput?.page, page)
        XCTAssertEqual(serviceSpy.receivedInput?.limit, limit)
    }
}

private final class CatServiceSpy: ServiceType {
    private(set) var receivedInput: CatServiceInput?
    var successData: [CatResponse]?
    var error: Error = CatAppError.server

    func fetchData(input: CatServiceInput) async throws -> [CatResponse] {
        receivedInput = input
        guard let successData else { throw error }
        return successData
    }
}
