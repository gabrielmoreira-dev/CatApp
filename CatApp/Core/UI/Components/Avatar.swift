import SwiftUI

extension Avatar {
    enum Layout {
        static let imageWidth: CGFloat = 80
        static let imageHeight: CGFloat = 80
    }
}

struct Avatar: View {
    let imageURL: String

    var body: some View {
        AsyncImage(url: URL(string: imageURL)) {
            $0.resizable()
        } placeholder: {
            ProgressView()
                .id(UUID())
        }
        .aspectRatio(contentMode: .fill)
        .frame(width: Layout.imageWidth, height: Layout.imageHeight)
        .clipShape(Circle())
    }
}
