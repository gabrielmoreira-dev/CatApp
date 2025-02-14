struct CatServiceInput {
    let page: Int
    let limit: Int
}

final class CatService: ServiceType {
    private let dependencies: HasApiClient

    init(dependencies: HasApiClient = DependencyContainer()) {
        self.dependencies = dependencies
    }

    func fetchData(input: CatServiceInput) async throws -> [CatResponse] {
        let endpoint = CatEndpoint.catList(page: input.page, limit: input.limit)
        return try await dependencies.apiClient.fetchData(from: endpoint)
    }
}
