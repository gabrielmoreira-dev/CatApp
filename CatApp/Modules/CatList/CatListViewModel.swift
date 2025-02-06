import SwiftUI

extension CatListViewModel {
    enum Constants {
        static let limit = 20
    }
}

@Observable
final class CatListViewModel {
    private let getCatItemsUseCase: any UseCaseType<GetCatItemsUseCaseInput, [CatItem]>
    private var page: Int = .zero
    private(set) var items: [CatItem] = []
    private(set) var state: ViewState = .loading
    private(set) var listState: ViewState = .success

    init(getCatItemsUseCase: any UseCaseType<GetCatItemsUseCaseInput, [CatItem]> = GetCatItemsUseCase()) {
        self.getCatItemsUseCase = getCatItemsUseCase
    }

    func loadItems() async {
        guard items.isEmpty else { return await loadMoreItems() }
        do {
            try await fetchData()
            state = .success
        } catch {
            state = .failure(getErrorViewModel(error: error))
        }
    }

    private func loadMoreItems() async {
        guard listState != .loading else { return }
        do {
            listState = .loading
            try await fetchData()
            listState = .success
        } catch {
            listState = .failure(getErrorViewModel(error: error))
        }
    }

    private func fetchData() async throws {
        let input = GetCatItemsUseCaseInput(page: page, limit: Constants.limit)
        let result = try await getCatItemsUseCase.execute(input: input)
        page += 1
        items.append(contentsOf: result.filter { !$0.breeds.isEmpty })
    }

    private func getErrorViewModel(error: Error) -> ErrorViewModel {
        ErrorViewModel(error: error as? CatAppError ?? .generic) { [weak self] in
            await self?.loadItems()
        }
    }
}
