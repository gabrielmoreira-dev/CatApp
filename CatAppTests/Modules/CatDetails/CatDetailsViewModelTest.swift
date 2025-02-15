@testable import CatApp
import XCTest

final class CatDetailsViewModelTest: XCTestCase {
    func testCatDetailsViewModel_WhenInit_ThenSetProperties() {
        let item = CatItem.dummy

        let sut = CatDetailsViewModel(item: item)

        XCTAssertEqual(sut.image, item.url)
        XCTAssertEqual(sut.title, item.breeds[0].name)
        XCTAssertEqual(sut.origin, item.breeds[0].origin)
        XCTAssertEqual(sut.temperament, item.breeds[0].temperament)
        XCTAssertEqual(sut.description, item.breeds[0].description)
        XCTAssertEqual(sut.adaptability, item.breeds[0].adaptability)
        XCTAssertEqual(sut.affectionLevel, item.breeds[0].affectionLevel)
        XCTAssertEqual(sut.childFriendly, item.breeds[0].childFriendly)
        XCTAssertEqual(sut.dogFriendly, item.breeds[0].dogFriendly)
        XCTAssertEqual(sut.energyLevel, item.breeds[0].energyLevel)
        XCTAssertEqual(sut.intelligence, item.breeds[0].intelligence)
        XCTAssertEqual(sut.socialNeeds, item.breeds[0].socialNeeds)
        XCTAssertEqual(sut.rare, item.breeds[0].rare)
    }
}
