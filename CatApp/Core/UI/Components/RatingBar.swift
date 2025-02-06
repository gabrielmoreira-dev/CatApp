import SwiftUI

struct RatingBar: View {
    let label: String
    let value: Int

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
            ForEach(1..<6) { i in
                StarIcon(isFilled: value >= i)
            }
        }
    }
}

#Preview {
    RatingBar(label: "Rare:", value: 0)
    RatingBar(label: "Rare:", value: 1)
    RatingBar(label: "Rare:", value: 2)
    RatingBar(label: "Rare:", value: 3)
    RatingBar(label: "Rare:", value: 4)
    RatingBar(label: "Rare:", value: 5)
}
