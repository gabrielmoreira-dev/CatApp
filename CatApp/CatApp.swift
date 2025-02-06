import SwiftUI

@main
struct CatApp: App {
    var body: some Scene {
        WindowGroup {
            CatListView()
                .withRouter()
        }
    }
}
