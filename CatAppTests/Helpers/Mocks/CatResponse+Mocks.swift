@testable import CatApp
import Foundation

extension CatResponse {
    static var dummy: Self {
        CatResponse(
            id: "Hb2N6tYTJ",
            url: "https://cdn2.thecatapi.com/images/Hb2N6tYTJ.jpg",
            breeds: [
                Breed(
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
        )
    }
}
