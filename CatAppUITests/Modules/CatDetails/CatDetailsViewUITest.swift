@testable import CatApp
import XCTest

final class CatDetailsViewUITest: XCTestCase {
    private lazy var app: XCUIApplication = {
        XCUIApplication()
    }()

    func testCatListView_WhenSuccess_ThenShowCatList() {
        let data = JSONLoader.load(from: "cat_list", for: Self.self)
        let responses = [URLBuilder.buildCatListURL() : LocalResponse(data: data)]
        let session = URLSessionLocal(responses: responses)

        app.launch(with: session)
        app.collectionViews.children(matching: .cell).element(boundBy: 0).tap()
        let elementsQuery = app.scrollViews.otherElements

        XCTAssert(elementsQuery.images.element(boundBy: 0).exists)
        XCTAssert(elementsQuery.staticTexts["Aegean"].exists)
        XCTAssert(elementsQuery.staticTexts["Greece"].exists)
        XCTAssert(elementsQuery.staticTexts["Affectionate, Social, Intelligent, Playful, Active"].exists)
        XCTAssert(elementsQuery.staticTexts["Adaptability:"].exists)
        XCTAssert(elementsQuery.staticTexts["Affection Level:"].exists)
        XCTAssert(elementsQuery.staticTexts["Child Friendly:"].exists)
        XCTAssert(elementsQuery.staticTexts["Dog Friendly:"].exists)
        XCTAssert(elementsQuery.staticTexts["Energy Level:"].exists)
        XCTAssert(elementsQuery.staticTexts["Intelligence:"].exists)
        XCTAssert(elementsQuery.staticTexts["Social Needs:"].exists)
        XCTAssert(elementsQuery.staticTexts["Rare:"].exists)
    }
}
