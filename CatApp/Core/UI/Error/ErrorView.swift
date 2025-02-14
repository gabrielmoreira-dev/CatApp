import SwiftUI

extension ErrorView {
    enum Layout {
        static let imageWidth: CGFloat = 250
        static let imageHeight: CGFloat = 250
        static let textSpacing: CGFloat = 18
        static let buttonHeight: CGFloat = 40
    }
}

struct ErrorView: View {
    let viewModel: ErrorViewModel

    var body: some View {
        VStack {
            Spacer()
            RoundedBorderImage(
                imageResource: viewModel.image,
                width: Layout.imageWidth,
                height: Layout.imageHeight
            )
            Spacer()
            Text(viewModel.title)
                .font(.title)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: Layout.textSpacing)
            Text(viewModel.description)
                .font(.title3)
                .multilineTextAlignment(.center)
            Spacer()
            Button {
                Task {
                    await viewModel.onTryAgain?()
                }
            } label: {
                Text(viewModel.buttonTitle)
                    .frame(maxWidth: .infinity, minHeight: Layout.buttonHeight)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    ErrorView(viewModel: ErrorViewModel(
        error: .generic,
        onTryAgain: nil
    ))
}
