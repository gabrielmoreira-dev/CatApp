struct CatServiceInput {
    let page: Int
    let limit: Int
}

final class CatService: ServiceType {
    private let apiClient: ApiClientType
    
    init(apiClient: ApiClientType = ApiClient()) {
        self.apiClient = apiClient
    }
    
    func fetchData(input: CatServiceInput) async throws -> [CatResponse] {
        let endpoint = CatEndpoint.catList(page: input.page, limit: input.limit)
        return try await apiClient.fetchData(from: endpoint)
    }
}
