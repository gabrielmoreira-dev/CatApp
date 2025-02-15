final class CatDetailsViewModel {
    private let item: CatItem

    init(item: CatItem) {
        self.item = item
    }

    var image: String {
        item.url
    }

    var title: String {
        item.breeds[0].name
    }

    var origin: String {
        item.breeds[0].origin
    }

    var temperament: String {
        item.breeds[0].temperament
    }

    var description: String {
        item.breeds[0].description
    }

    var adaptability: Int {
        item.breeds[0].adaptability
    }

    var affectionLevel: Int {
        item.breeds[0].affectionLevel
    }

    var childFriendly: Int {
        item.breeds[0].childFriendly
    }

    var dogFriendly: Int {
        item.breeds[0].dogFriendly
    }

    var energyLevel: Int {
        item.breeds[0].energyLevel
    }

    var intelligence: Int {
        item.breeds[0].intelligence
    }

    var socialNeeds: Int {
        item.breeds[0].socialNeeds
    }

    var rare: Int {
        item.breeds[0].rare
    }
}
