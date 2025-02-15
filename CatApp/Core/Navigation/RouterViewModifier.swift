import SwiftUI

struct RouterViewModifier: ViewModifier {
    @State private var router = Router()

    func body(content: Content) -> some View {
        NavigationStack(path: $router.path) {
            content
                .environment(router)
                .navigationDestination(for: Route.self) { route in
                    routeView(for: route)
                }
        }
    }

    private func routeView(for route: Route) -> some View {
        Group {
            switch route {
            case .details(let item):
                let viewModel = CatDetailsViewModel(item: item)
                CatDetailsView(viewModel: viewModel)
            }
        }
        .environment(router)
    }
}
