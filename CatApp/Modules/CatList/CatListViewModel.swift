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
        let input = GetCatItemsUseCaseInput(page: page, limit: limit)
        do {
            let result = try await getCatItemsUseCase.execute(input: input)
            page += 1
            items.append(contentsOf: result.filter { !$0.breeds.isEmpty })
            state = .success
        } catch {
            state = .failure(error as? CatAppError ?? .generic)
        }
    }
}
