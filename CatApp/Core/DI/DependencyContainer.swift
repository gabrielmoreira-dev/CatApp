final class DependencyContainer: HasURLSession, HasApiClient {
    private let orchestrator: DependencyOrchestrator

    lazy var session: any URLSessionType = {
        orchestrator.resolve()
    }()

    lazy var apiClient: any ApiClientType = {
        orchestrator.resolve()
    }()

    init(orchestrator: DependencyOrchestrator = .shared) {
        self.orchestrator = orchestrator
    }
}
