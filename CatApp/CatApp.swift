import SwiftUI

@main
struct CatApp: App {
    var body: some Scene {
        WindowGroup {
            CatListView(viewModel: DependencyInjection.catListViewModel)
                .withRouter()
        }
    }
}
