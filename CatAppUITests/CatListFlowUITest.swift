import XCTest

final class CatListFlowUITest: XCTestCase {
    private lazy var app: XCUIApplication = {
        let app = XCUIApplication()
        app.launch()
        return app
    }()

    func testCatListView_WhenSelectItem_ThenNavigateToCatDetailsView() {
        let elementsQuery = app.scrollViews.otherElements

        app.collectionViews
            .children(matching: .cell)
            .element(boundBy: 0)
            .tap()

        XCTAssert(elementsQuery.images.element(boundBy: 0).exists)
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
