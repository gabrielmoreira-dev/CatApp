import SwiftUI

@Observable
final class CatListViewModel {
    private let getCatItemsUseCase: any UseCaseType<GetCatItemsUseCaseInput, [CatItem]>
    private let limit = 10
    private var page = 0
    private(set) var items: [CatItem] = []
    private(set) var state: ViewState = .loading

    init(getCatItemsUseCase: any UseCaseType<GetCatItemsUseCaseInput, [CatItem]> = GetCatItemsUseCase()) {
        self.getCatItemsUseCase = getCatItemsUseCase
    }

    func loadItems() async {
        if items.isEmpty {
            state = .loading
        }
        do {
            let input = GetCatItemsUseCaseInput(page: page, limit: limit)
            let result = try await getCatItemsUseCase.execute(input: input)
            handleSuccess(result)
        } catch {
            handleError(error)
        }
    }

    private func handleSuccess(_ result: [CatItem]) {
        page += 1
        items.append(contentsOf: result.filter { !$0.breeds.isEmpty })
        state = .success
    }

    private func handleError(_ error: Error) {
        guard items.isEmpty else { return }
        let errorViewModel = ErrorViewModel(error: error as? CatAppError ?? .generic) { [weak self] in
            await self?.loadItems()
        }
        state = .failure(errorViewModel)
    }
}
