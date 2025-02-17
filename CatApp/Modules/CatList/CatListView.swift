import SwiftUI

extension CatListView {
    enum Constants {
        static let title = String(localized: "Cats")
    }
}

struct CatListView: View {
    @State private var viewModel: CatListViewModel
    @Environment(Router.self) var router

    init(viewModel: CatListViewModel = CatListViewModel()) {
        self.viewModel = viewModel
    }

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
        List {
            ForEach(Array(viewModel.items.enumerated()), id: \.1.id) { (index, item) in
                CatListItem(item: item)
                    .onAppear {
                        onScrolled(index)
                    }
                    .onTapGesture {
                        router.navigateToDetails(item: item)
                    }
            }
            Section {
                bottomContent
            }
            .listSectionSeparator(.hidden, edges: .bottom)
        }
        .listStyle(.plain)
    }

    private var bottomContent: some View {
        Group {
            switch viewModel.listState {
            case .success:
                VStack { }
            case .loading:
                ProgressView()
                    .id(UUID())
                    .frame(maxWidth: .infinity)
            case .failure(let viewModel):
                ErrorMessage(viewModel: viewModel)
            }
        }
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
