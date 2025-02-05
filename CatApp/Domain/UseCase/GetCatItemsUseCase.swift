struct GetCatItemsUseCaseInput {
    let page: Int
    let limit: Int
}

final class GetCatItemsUseCase: UseCaseType {
    private let repository: CatRepositoryType

    init(repository: CatRepositoryType = CatRepository()) {
        self.repository = repository
    }

    func onExecute(input: GetCatItemsUseCaseInput) async throws -> [CatItem] {
        try await repository.getCatItems(page: input.page, limit: input.limit)
    }
}
