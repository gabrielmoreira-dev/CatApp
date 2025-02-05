@testable import CatApp
import XCTest

final class GetCatItemsUseCaseTest: XCTestCase {
    private lazy var sut: GetCatItemsUseCase = {
        GetCatItemsUseCase(repository: repositorySpy)
    }()

    private lazy var repositorySpy: CatRepositorySpy = {
        CatRepositorySpy()
    }()

    func testExecute_WhenSuccess_ThenReturnItems() async throws {
        repositorySpy.successData = [CatItem.dummy]
        let input = GetCatItemsUseCaseInput(page: 0, limit: 1)

        let result = try await sut.execute(input: input)

        XCTAssertEqual(result, [CatItem.dummy])
    }

    func testGetCatItems_WhenFailure_ThenThrowError() async {
        let input = GetCatItemsUseCaseInput(page: 0, limit: 1)
        var expectedError: Error?

        do {
            let _ = try await sut.execute(input: input)
        } catch {
            expectedError = error
        }

        XCTAssertNotNil(expectedError)
    }

    func testGetCatItems_WhenCalled_ThenPassParams() async throws {
        repositorySpy.successData = [CatItem.dummy]
        let input = GetCatItemsUseCaseInput(page: 0, limit: 1)

        let _ = try await sut.execute(input: input)

        XCTAssertEqual(repositorySpy.receivedPage, input.page)
        XCTAssertEqual(repositorySpy.receivedLimit, input.limit)
    }
}

private final class CatRepositorySpy: CatRepositoryType {
    private(set) var receivedPage: Int?
    private(set) var receivedLimit: Int?
    var successData: [CatItem]?
    var error: Error = CatAppError.generic

    func getCatItems(page: Int, limit: Int) async throws -> [CatItem] {
        receivedPage = page
        receivedLimit = limit
        guard let successData else { throw error }
        return successData
    }
}
