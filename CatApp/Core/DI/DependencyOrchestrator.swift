import Foundation

final class DependencyOrchestrator {
    static let shared: DependencyOrchestrator = .init()
    private var dependencies: [String: () -> Any] = [:]

    private init() {}

    func resolve<T>() -> T {
        guard let dependency: T = dependencies[String(reflecting: T.self)]?() as? T else {
            fatalError("Could not resolve \(T.self)")
        }
        return dependency
    }

    static func whenFindProtocol<T>(_ type: T.Type, returns builder: @escaping () -> T) {
        shared.dependencies[String(reflecting: type)] = builder
    }
}

extension DependencyOrchestrator {
    static func registerDependencies() {
        whenFindProtocol(URLSessionType.self, returns: {
            ProcessInfo.processInfo.decode(URLSessionLocal.self) ?? URLSession.shared as URLSessionType
        })
        whenFindProtocol(ApiClientType.self, returns: { ApiClient() })
    }
}
