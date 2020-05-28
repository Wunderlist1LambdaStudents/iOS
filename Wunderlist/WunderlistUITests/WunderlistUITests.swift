//
//  WunderlistUITests.swift
//  WunderlistUITests
//
//  Created by Bradley Diroff on 5/26/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import XCTest

class WunderlistUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    var searchBar: XCUIElement {
        return app.otherElements["Wunderlist.searchBar"]
    }
    
    var loginButton: XCUIElement {
        return app/*@START_MENU_TOKEN@*/.buttons["Sign In"].staticTexts["Sign In"]/*[[".buttons[\"Sign In\"].staticTexts[\"Sign In\"]",".staticTexts[\"Sign In\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testKeyboardAbleToType() throws {
        let app = XCUIApplication()
        app.launch()
        
        let password = app.textFields["Password"]
        let userName = app.textFields["Name"]
        
        XCTAssertTrue(password.exists)
        XCTAssertTrue(userName.exists)

        
        password.tap()
        userName.tap()
                
    }
    
    func testSegmentedControlExistence() throws {
        
        app = XCUIApplication()
        app.launch()
        
        loginButton.tap()
        
        let segmentDay = app/*@START_MENU_TOKEN@*/.buttons["Day"]/*[[".segmentedControls.buttons[\"Day\"]",".buttons[\"Day\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let segmentMonth = app/*@START_MENU_TOKEN@*/.buttons["Month"]/*[[".segmentedControls.buttons[\"Month\"]",".buttons[\"Month\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        
        XCTAssertTrue(segmentDay.exists)
        XCTAssertTrue(segmentMonth.exists)
        
        segmentMonth.tap()
        segmentDay.tap()
        
    }
    
    func testSearchType() throws {
        app = XCUIApplication()
        app.launch()
        
        loginButton.tap()
        
        XCTAssertTrue(searchBar.exists)
        
        searchBar.tap()
        searchBar.typeText("Testing")
                
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}

