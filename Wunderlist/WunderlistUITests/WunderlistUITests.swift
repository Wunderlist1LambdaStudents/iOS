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
    
    var addButton: XCUIElement {
        return app.buttons["Wunderlist.addTask"]
    }
    
    var loginButton: XCUIElement {
        return app/*@START_MENU_TOKEN@*/.buttons["Sign In"].staticTexts["Sign In"]/*[[".buttons[\"Sign In\"].staticTexts[\"Sign In\"]",".staticTexts[\"Sign In\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
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
    
    func testNoLoginAllowed() throws {
        
        app = XCUIApplication()
        app.launch()
    
        app.staticTexts["Sign In"].tap()
        
        let alert = app.alerts["Error"].scrollViews.otherElements.buttons["Dismiss"]
        
        XCTAssertTrue(alert.exists)
        
        alert.tap()
    }
    
    func testCreatingAUser() throws {
        
        app = XCUIApplication()
        app.launch()
        
        let number = Int.random(in: 500 ... 900)
        
        app/*@START_MENU_TOKEN@*/.staticTexts["Don't have an account?"]/*[[".buttons[\"Don't have an account?\"].staticTexts[\"Don't have an account?\"]",".staticTexts[\"Don't have an account?\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        app.textFields["Name"].tap()
        app.textFields["Name"].typeText("\(number)")
        app.textFields["Password"].tap()
        app.textFields["Password"].typeText("\(number)")
        
    }
    
    func testSearchType() throws {
        app = XCUIApplication()
        app.launch()
        
        app.textFields["Name"].tap()
        app.textFields["Name"].typeText("aaaa")
        app.textFields["Password"].tap()
        app.textFields["Password"].typeText("aaaa")
        loginButton.tap()
        
        sleep(3)
        
        XCTAssertTrue(searchBar.exists)
        
        searchBar.tap()
        searchBar.typeText("Testing")
                
    }
    
    func testNewController() throws {
        app = XCUIApplication()
        app.launch()
        
        app.textFields["Name"].tap()
        app.textFields["Name"].typeText("aaaa")
        app.textFields["Password"].tap()
        app.textFields["Password"].typeText("aaaa")
        loginButton.tap()
        
        sleep(3)
        
        XCTAssertTrue(addButton.exists)
        addButton.tap()
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

