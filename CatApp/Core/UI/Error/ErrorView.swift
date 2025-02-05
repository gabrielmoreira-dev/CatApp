import SwiftUI

extension ErrorView {
    enum Layout {
        static let imageWidth: CGFloat = 220
        static let imageHeight: CGFloat = 220
        static let textSpacing: CGFloat = 18
        static let buttonHeight: CGFloat = 40
        static let horizontalSpacing: CGFloat = 20
        static let verticalSpacing: CGFloat = 32
    }
}

struct ErrorView: View {
    let viewModel: ErrorViewModel

    var body: some View {
        VStack {
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
                .font(.headline)
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
        .padding(EdgeInsets(
            top: Layout.verticalSpacing,
            leading: Layout.horizontalSpacing,
            bottom: Layout.verticalSpacing,
            trailing: Layout.horizontalSpacing
        ))
    }
}

#Preview {
    ErrorView(viewModel: ErrorViewModel(
        error: .generic,
        onTryAgain: nil
    ))
}
