//
//  GourmapUITests.swift
//  GourmapUITests
//
//  Created by hiro on 2021/08/28.
//

import XCTest

class GourmapUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        app.textFields.element(boundBy: 0).doubleTap()
        app.textFields.element(boundBy: 0).typeText("yama.ri0023ef@gmail.com")
        
        UIPasteboard.general.string = "password"
        app.secureTextFields.element(boundBy: 0).doubleTap()
        //app.menuItems.element(boundBy: 0).tap()
        app.secureTextFields.element(boundBy: 0).typeText("password")
        //app.keys["p"].tap()
        app.buttons.element(boundBy: 0).tap()

        app.otherElements["My Location"].waitForExistence(timeout: 600)
        app.buttons.element(boundBy: 0).tap()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
