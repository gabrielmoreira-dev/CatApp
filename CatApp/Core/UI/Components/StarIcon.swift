import SwiftUI

extension StarIcon {
    enum Layout {
        static let filledIamge = "star.fill"
        static let borderedImage = "star"
        static let width: CGFloat = 24
    }
}

struct StarIcon: View {
    let isFilled: Bool

    var body: some View {
        Image(systemName: isFilled ? Layout.filledIamge : Layout.borderedImage)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: Layout.width)
            .foregroundStyle(.yellow)

    }
}

#Preview {
    StarIcon(isFilled: true)
    StarIcon(isFilled: false)
}
