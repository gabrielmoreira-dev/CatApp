import Foundation

enum DependencyInjection {
    static var catListViewModel: CatListViewModel = {
        CatListViewModel(getCatItemsUseCase: getCatItemsUseCase)
    }()

    private static var getCatItemsUseCase: any UseCaseType<GetCatItemsUseCaseInput, [CatItem]> = {
        GetCatItemsUseCase(repository: catRepository)
    }()

    private static var catRepository: CatRepositoryType = {
        CatRepository(service: catService)
    }()

    private static var catService: any ServiceType<CatServiceInput, [CatResponse]> = {
        CatService(apiClient: apiClient)
    }()

    private static var apiClient: ApiClientType = {
        ApiClient(session: urlSession)
    }()

    private static var urlSession: URLSessionType = {
        ProcessInfo.processInfo.decode(URLSessionLocal.self) ?? URLSession.shared as URLSessionType
    }()
}
