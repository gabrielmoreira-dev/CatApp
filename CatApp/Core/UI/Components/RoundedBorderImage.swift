import SwiftUI

extension RoundedBorderImage {
    enum Layout {
        static let cornerRadius: CGFloat = 30
    }
}

struct RoundedBorderImage: View {
    let imageResource: ImageResource
    let width: CGFloat
    let height: CGFloat

    var body: some View {
        Image(imageResource)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: Layout.cornerRadius))
    }
}
