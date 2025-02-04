protocol CatRepositoryType {
    func getCatItems(page: Int, limit: Int) async throws -> [CatItem]
}
