import SwiftUI

struct CatListItem: View {
    let name: String
    let origin: String
    let temperament: String
    let imageURL: String

    init(item: CatItem) {
        self.name = item.breeds[0].name
        self.origin = item.breeds[0].origin
        self.temperament = item.breeds[0].temperament
        self.imageURL = item.url
    }

    var body: some View {
        HStack {
            Avatar(imageURL: imageURL)
            VStack(alignment: .leading) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.semibold)
                Text(origin)
                    .font(.caption)
                    .fontWeight(.light)
                Text(temperament)
                    .font(.caption)
                    .fontWeight(.light)
            }
        }
    }
}

#Preview {
    CatListItem(item: CatItem(
        id: "Hb2N6tYTJ",
        url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg",
        breeds: [
            CatItem.Breed(
                name: "Aegean",
                description: "",
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
}

