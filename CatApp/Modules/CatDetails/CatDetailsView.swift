import SwiftUI

extension CatDetailsView {
    enum Constants {
        static let adaptabilityLabel = String(localized: "Adaptability:")
        static let affectionLevelLabel = String(localized: "Affection Level:")
        static let childFriendlyLabel = String(localized: "Child Friendly:")
        static let dogFriendlyLabel = String(localized: "Dog Friendly:")
        static let energyLevelLabel = String(localized: "Energy Level:")
        static let intelligenceLabel = String(localized: "Intelligence:")
        static let socialNeedsLabel = String(localized: "Social Needs:")
        static let rareLabel = String(localized: "Rare:")
    }
}

struct CatDetailsView: View {
    private let viewModel: CatDetailsViewModel

    init(viewModel: CatDetailsViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        ScrollView {
            AsyncImage(url: URL(string: viewModel.image)) {
                $0.resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity)
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Text(viewModel.origin)
                    .font(.title3)
                    .fontWeight(.light)
                Text(viewModel.temperament)
                    .font(.subheadline)
                    .fontWeight(.light)
                Divider()
                Text(viewModel.description)
                    .font(.body)
                Divider()
                RatingBar(label: Constants.adaptabilityLabel, value: viewModel.adaptability)
                RatingBar(label: Constants.affectionLevelLabel, value: viewModel.affectionLevel)
                RatingBar(label: Constants.childFriendlyLabel, value: viewModel.childFriendly)
                RatingBar(label: Constants.dogFriendlyLabel, value: viewModel.dogFriendly)
                RatingBar(label: Constants.energyLevelLabel, value: viewModel.energyLevel)
                RatingBar(label: Constants.intelligenceLabel, value: viewModel.intelligence)
                RatingBar(label: Constants.socialNeedsLabel, value: viewModel.socialNeeds)
                RatingBar(label: Constants.rareLabel, value: viewModel.rare)
            }
            .padding()
        }
        .frame(alignment: .leading)
    }
}

#Preview {
    let viewModel = CatDetailsViewModel(item: CatItem(
        id: "Hb2N6tYTJ",
        url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg",
        breeds: [
            CatItem.Breed(
                name: "Aegean",
                description: "Native to the Greek islands known as the Cyclades in the Aegean Sea, these are natural cats, meaning they developed without humans getting involved in their breeding. As a breed, Aegean Cats are rare, although they are numerous on their home islands. They are generally friendly toward people and can be excellent cats for families with children.",
                origin: "Greece",
                temperament: "Affectionate, Social, Intelligent, Playful, Active",
                adaptability: 5,
                affectionLevel: 4,
                childFriendly: 4,
                dogFriendly: 4,
                energyLevel: 3,
                intelligence: 3,
                socialNeeds: 4,
                rare: 0
            )
        ]
    ))
    return CatDetailsView(viewModel: viewModel)
}
