@testable import CatApp
import XCTest

final class CatListViewUITest: XCTestCase {
    private lazy var app: XCUIApplication = {
        XCUIApplication()
    }()

    func testCatListView_WhenSuccess_ThenShowCatList() {
        let data = JSONLoader.load(from: "cat_list", for: Self.self)
        let responses = [URLBuilder.buildCatListURL() : LocalResponse(data: data)]
        let session = URLSessionLocal(responses: responses)

        app.launch(with: session)
        let cell = app.collectionViews.children(matching: .cell).element(boundBy: 0)

        XCTAssert(app.navigationBars["Cats"].staticTexts["Cats"].exists)
        XCTAssert(cell.exists)
        XCTAssert(cell.staticTexts["Aegean"].exists)
        XCTAssert(cell.staticTexts["Greece"].exists)
        XCTAssert(cell.staticTexts["Affectionate, Social, Intelligent, Playful, Active"].exists)
    }

    func testCatListView_WhenLoadMoreItemsWithSuccess_ThenShowCatList() {
        let data = JSONLoader.load(from: "cat_list", for: Self.self)
        let responses = [
            URLBuilder.buildCatListURL(page: 0) : LocalResponse(data: data),
            URLBuilder.buildCatListURL(page: 1) : LocalResponse(data: data)
        ]
        let session = URLSessionLocal(responses: responses)

        app.launch(with: session)
        app.swipeUp(velocity: .fast)
        let cell = app.collectionViews.children(matching: .cell).element(boundBy: 8)

        XCTAssert(app.navigationBars["Cats"].staticTexts["Cats"].exists)
        XCTAssert(cell.exists)
        XCTAssert(cell.staticTexts["York Chocolate"].exists)
        XCTAssert(cell.staticTexts["United States"].exists)
        XCTAssert(cell.staticTexts["Playful, Social, Intelligent, Curious, Friendly"].exists)
    }

    func testCatListView_WhenLoadMoreItemsWithError_ThenShowErrorMessage() {
        let data = JSONLoader.load(from: "cat_list", for: Self.self)
        let responses = [
            URLBuilder.buildCatListURL(page: 0) : LocalResponse(data: data),
            URLBuilder.buildCatListURL(page: 1) : LocalResponse(data: nil)
        ]
        let session = URLSessionLocal(responses: responses)

        app.launch(with: session)
        app.swipeUp(velocity: .fast)
        app.swipeUp(velocity: .fast)

        XCTAssert(app.navigationBars["Cats"].staticTexts["Cats"].exists)
        XCTAssert(app.collectionViews.staticTexts["Something went wrong"].exists)
        XCTAssert(app.collectionViews.buttons["Try again"].exists)
    }

    func testCatListView_WhenGenericError_ThenShowGenericErrorView() {
        let responses = [URLBuilder.buildCatListURL() : LocalResponse(data: nil, error: .generic)]
        let session = URLSessionLocal(responses: responses)

        app.launch(with: session)

        XCTAssert(app.navigationBars["Cats"].staticTexts["Cats"].exists)
        XCTAssert(app.images["GenericError"].exists)
        XCTAssert(app.staticTexts["Something went wrong"].exists)
        XCTAssert(app.staticTexts["We are working to resolve the issue"].exists)
        XCTAssert(app.buttons["Try again"].exists)
    }

    func testCatListView_WhenInternetError_ThenShowInternetErrorView() {
        let responses = [URLBuilder.buildCatListURL() : LocalResponse(data: nil, error: .internet)]
        let session = URLSessionLocal(responses: responses)

        app.launch(with: session)

        XCTAssert(app.navigationBars["Cats"].staticTexts["Cats"].exists)
        XCTAssert(app.images["InternetError"].exists)
        XCTAssert(app.staticTexts["It seems like there is no internet"].exists)
        XCTAssert(app.staticTexts["Check your connection and try again"].exists)
        XCTAssert(app.buttons["Try again"].exists)
    }
}
