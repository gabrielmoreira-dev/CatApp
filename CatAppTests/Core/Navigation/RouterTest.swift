@testable import CatApp
import XCTest

final class RouterTest: XCTestCase {
    func testNavigateToDetails_WhenCalled_ThenAppendRouteToPath() {
        let sut = Router()

        sut.navigateToDetails(item: .dummy)

        XCTAssertEqual(sut.path.count, 1)
    }
}
