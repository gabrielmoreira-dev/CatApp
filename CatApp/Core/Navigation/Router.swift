import SwiftUI

@Observable
final class Router {
    var path = NavigationPath()

    func navigateToDetails(item: CatItem) {
        path.append(Route.details(item: item))
    }
}
