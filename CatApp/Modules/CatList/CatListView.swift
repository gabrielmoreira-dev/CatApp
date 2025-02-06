import SwiftUI

extension CatListView {
    enum Constants {
        static let title = String(localized: "Cats")
    }
}

struct CatListView: View {
    @State private var viewModel = CatListViewModel()
    @Environment(Router.self) var router

    var body: some View {
        Group {
            switch viewModel.state {
            case .success:
                content
            case .loading:
                ProgressView()
            case .failure(let viewModel):
                ErrorView(viewModel: viewModel)
            }
        }
        .navigationTitle(Constants.title)
        .task {
             await viewModel.loadItems()
        }
    }

    private var content: some View {
        List(Array(viewModel.items.enumerated()), id: \.1.id) { (index, item) in
            CatListItem(item: item)
                .onAppear {
                    onScrolled(index)
                }
                .onTapGesture {
                    router.navigateToDetails(item: item)
                }
        }
        .listStyle(.plain)
    }

    func onScrolled(_ index: Int) {
        if viewModel.items.count - index == 5 {
            Task {
                await viewModel.loadItems()
            }
        }
    }
}

#Preview {
    NavigationStack {
        CatListView()
    }
}
