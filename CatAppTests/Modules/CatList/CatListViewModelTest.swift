@testable import CatApp
import XCTest

final class CatListViewModelTest: XCTestCase {
    private lazy var sut: CatListViewModel = {
        CatListViewModel(getCatItemsUseCase: useCaseSpy)
    }()

    private lazy var useCaseSpy: GetCatItemsUseCaseSpy = {
        GetCatItemsUseCaseSpy()
    }()

    func testLoadItems_WhenStarted_ThenStateIsLoading() {
        XCTAssertEqual(sut.state, .loading)
    }

    func testLoadItems_WhenSuccess_ThenStateIsSuccess() async {
        useCaseSpy.successData = [CatItem.dummy]

        await sut.loadItems()

        XCTAssertEqual(sut.state, .success)
        XCTAssertEqual(sut.items, [CatItem.dummy])
    }

    func testLoadItems_WhenFailure_ThenStateIsFailure() async {
        await sut.loadItems()

        XCTAssertEqual(sut.state, .failure(.generic))
    }

    func testLoadItems_WhenCalled_ThenPassParams() async throws {
        await sut.loadItems()

        XCTAssertEqual(useCaseSpy.receivedInput?.page, 0)
        XCTAssertEqual(useCaseSpy.receivedInput?.limit, 10)
    }
}

private final class GetCatItemsUseCaseSpy: UseCaseType {
    private(set) var receivedInput: GetCatItemsUseCaseInput?
    var successData: [CatItem]?
    var error: Error = CatAppError.generic

    func onExecute(input: GetCatItemsUseCaseInput) async throws -> [CatItem] {
        receivedInput = input
        guard let successData else { throw error }
        return successData
    }
}
