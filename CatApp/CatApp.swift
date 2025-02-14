import SwiftUI

@main
struct CatApp: App {
    var body: some Scene {
        DependencyOrchestrator.registerDependencies()
        return WindowGroup {
            CatListView()
                .withRouter()
        }
    }
}
