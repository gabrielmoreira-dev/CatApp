extension CatResponse {
    func toCatItem() -> CatItem {
        CatItem(id: id, url: url, breeds: breeds.map { $0.toCatItem() })
    }
}

extension CatResponse.Breed {
    func toCatItem() -> CatItem.Breed {
        CatItem.Breed(
            name: name,
            description: description,
            origin: origin,
            temperament: temperament,
            adaptability: adaptability,
            affectionLevel: affectionLevel,
            childFriendly: childFriendly,
            dogFriendly: dogFriendly,
            energyLevel: energyLevel,
            intelligence: intelligence,
            socialNeeds: socialNeeds,
            rare: rare
        )
    }
}
