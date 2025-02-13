@testable import CatApp
import XCTest

extension XCUIApplication {
    func launch(with session: URLSessionLocal) {
        guard let sessionData = try? JSONEncoder().encode(session),
              let sessionJson = String(data: sessionData, encoding: .utf8) else {
            return
        }
        launchEnvironment[String(describing: URLSessionLocal.self)] = sessionJson
        launch()
    }
}
