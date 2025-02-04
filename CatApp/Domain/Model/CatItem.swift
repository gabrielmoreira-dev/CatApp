struct CatItem: Equatable {
    let id: String
    let url: String
    let breeds: [Breed]

    struct Breed: Equatable {
        let name: String
        let description: String
        let origin: String
        let temperament: String
        let adaptability: Int
        let affectionLevel: Int
        let childFriendly: Int
        let dogFriendly: Int
        let energyLevel: Int
        let intelligence: Int
        let socialNeeds: Int
        let rare: Int
    }
}
