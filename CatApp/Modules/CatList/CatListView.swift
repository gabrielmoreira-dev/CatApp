import SwiftUI

struct CatListView: View {
    @State private var viewModel = CatListViewModel()

    var body: some View {
        VStack {
            switch viewModel.state {
            case .success:
                content
            case .loading:
                ProgressView()
            case .failure(let viewModel):
                ErrorView(viewModel: viewModel)
            }
        }
        .navigationTitle("Cats")
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
