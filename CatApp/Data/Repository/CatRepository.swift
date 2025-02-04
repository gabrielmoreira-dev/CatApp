final class CatRepository: CatRepositoryType {
    private let service: any ServiceType<CatServiceInput, [CatResponse]>

    init(service: any ServiceType<CatServiceInput, [CatResponse]> = CatService()) {
        self.service = service
    }

    func getCatItems(page: Int, limit: Int) async throws -> [CatItem] {
        let input = CatServiceInput(page: page, limit: limit)
        let result = try await service.fetchData(input: input)
        return result.map { $0.toCatItem() }
    }
}
