import SwiftUI

struct ErrorMessage: View {
    let viewModel: ErrorViewModel

    var body: some View {
        HStack {
            Text(viewModel.title)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
                .fontWeight(.light)
            Button(viewModel.buttonTitle) {
                Task {
                    await viewModel.onTryAgain?()
                }
            }
            .foregroundStyle(.blue)
        }
    }
}

#Preview {
    ErrorMessage(viewModel: ErrorViewModel(
        error: .generic,
        onTryAgain: nil
    ))
}
