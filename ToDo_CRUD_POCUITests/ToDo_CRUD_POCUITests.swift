//
//  ToDo_CRUD_POCUITests.swift
//  ToDo_CRUD_POCUITests
//
//  Created by Sandesh on 23/03/20.
//  Copyright © 2020 Sandesh. All rights reserved.
//

import XCTest

class ToDo_CRUD_POCUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }


    
    func testTaskSave() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        XCUIApplication().tables.staticTexts["Done"].tap()
    }

    func testTaskAdd() {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()
        
        app.navigationBars["ToDo"].buttons["Add"].tap()
        app.alerts["Add Task"].scrollViews.otherElements.buttons["add"].tap()
        
    }
    
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }

}
