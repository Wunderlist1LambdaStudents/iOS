//
//  WunderlistTests.swift
//  WunderlistTests
//
//  Created by Bradley Diroff on 5/26/20.
//  Copyright © 2020 Bradley Diroff. All rights reserved.
//

import XCTest
@testable import Wunderlist

class WunderlistTests: XCTestCase {
    
    func testLogin() throws {
        let loginPass = expectation(description: "loginPass")
        
        let userController = UserController()
        
        let username = "aaaa"
        let password = "aaaa"
        
        userController.loginUser(username: username,
        password: password) { result in
            
            loginPass.fulfill()
            
        }
        wait(for: [loginPass], timeout: 15)
        
    }
    
    func testTokenNotNil() throws {
        let loginPass3 = expectation(description: "loginPass")
        
        let userController = UserController()
        
        let username = "aaaa"
        let password = "aaaa"
        
        userController.loginUser(username: username,
        password: password) { result in
            
            loginPass3.fulfill()
            
        }
        wait(for: [loginPass3], timeout: 15)
        
        XCTAssertNotNil(userController.bearer)
        
    }
    
    func testLoginToken() throws {
        let loginPass2 = expectation(description: "loginPass")
        
        let userController = UserController()
        
        let username = "aaaa"
        let password = "aaaa"
        
        userController.loginUser(username: username,
        password: password) { result in
            
            print("loginPass")
            loginPass2.fulfill()
            
        }
        wait(for: [loginPass2], timeout: 15)
        
        XCTAssertNotEqual(userController.bearer?.token, "")
        
    }
    
    func testFetchingData() throws {
        
        let didFinish = expectation(description: "didFinish")
        
        var pickedUpEntries: [EntryRepresentation] = []
        
        let entryController = EntryController()
        
        entryController.fetchEntriesFromAPI {_ in
            
            pickedUpEntries = entryController.entries
            didFinish.fulfill()
            
        }
        
        wait(for: [didFinish], timeout: 15)
        XCTAssertLessThan([EntryRepresentation]().count, pickedUpEntries.count)
        
    }
    
    func testSavingObject() throws {
      //  let entry = 
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
