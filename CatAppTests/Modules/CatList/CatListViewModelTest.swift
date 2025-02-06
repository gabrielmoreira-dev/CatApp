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
        useCaseSpy.successData = [.dummy]

        await sut.loadItems()

        XCTAssertEqual(sut.state, .success)
        XCTAssertEqual(sut.items, [.dummy])
    }

    func testLoadItems_WhenFailure_ThenStateIsFailure() async {
        await sut.loadItems()

        XCTAssertEqual(sut.state, .failure(ErrorViewModel(error: .generic, onTryAgain: nil)))
    }

    func testLoadItems_WhenLoadMoreItems_ThenStateIsSuccess() async {
        useCaseSpy.successData = [.dummy]

        await sut.loadItems()
        await sut.loadItems()

        XCTAssertEqual(sut.state, .success)
        XCTAssertEqual(sut.listState, .success)
        XCTAssertEqual(sut.items, [.dummy, .dummy])
    }

    func testLoadMoreItems_WhenFailure_ThenListStateIsFailure() async {
        useCaseSpy.successData = [.dummy]

        await sut.loadItems()
        useCaseSpy.successData = nil
        await sut.loadItems()

        XCTAssertEqual(sut.state, .success)
        XCTAssertEqual(sut.listState, .failure(ErrorViewModel(error: .generic, onTryAgain: nil)))
        XCTAssertEqual(sut.items, [.dummy])
    }

    func testLoadItems_WhenCalled_ThenPassParams() async throws {
        await sut.loadItems()

        XCTAssertEqual(useCaseSpy.receivedInputs.count, 1)
        XCTAssertEqual(useCaseSpy.receivedInputs.first?.page, 0)
        XCTAssertEqual(useCaseSpy.receivedInputs.first?.limit, 20)
    }

    func testLoadItems_WhenTryAgain_ThenCallUseCase() async {
        await sut.loadItems()

        switch sut.state {
        case .failure(let viewModel):
            await viewModel.onTryAgain?()
        default:
            XCTFail("Should be failure")
        }

        XCTAssertEqual(useCaseSpy.receivedInputs.count, 2)
    }
}

private final class GetCatItemsUseCaseSpy: UseCaseType {
    private(set) var receivedInputs: [GetCatItemsUseCaseInput] = []
    var successData: [CatItem]?
    var error: Error = CatAppError.generic

    func onExecute(input: GetCatItemsUseCaseInput) async throws -> [CatItem] {
        receivedInputs.append(input)
        guard let successData else { throw error }
        return successData
    }
}
