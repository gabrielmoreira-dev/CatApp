@testable import CatApp
import XCTest

final class ErrorViewModelTest: XCTestCase {
    func testErrorViewModel_WhenIsGenericError_ThenVerifyProps() {
        let sut = ErrorViewModel(error: .generic, onTryAgain: nil)

        XCTAssertEqual(sut.image, .genericError)
        XCTAssertEqual(sut.title, "Something went wrong")
        XCTAssertEqual(sut.description, "We are working to resolve the issue")
        XCTAssertEqual(sut.buttonTitle, "Try again")
    }

    func testErrorViewModel_WhenIsInternetError_ThenVerifyProps() {
        let sut = ErrorViewModel(error: .internet, onTryAgain: nil)

        XCTAssertEqual(sut.image, .internetError)
        XCTAssertEqual(sut.title, "It seems like there is no internet")
        XCTAssertEqual(sut.description, "Check your connection and try again")
        XCTAssertEqual(sut.buttonTitle, "Try again")
    }
}
