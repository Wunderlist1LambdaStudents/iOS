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

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testLogin() throws {
        let loginPass = expectation(description: "loginPass")
        
        let userController = UserController()
        
    }
    
    func testFetchingData() throws {
        
        let didFinish = expectation(description: "didFinish")
        
        var pickedUpEntries: [EntryRepresentation] = []
        
        let entryController = EntryController()
        
        entryController.fetchEntriesFromAPI {_ in
            
            didFinish.fulfill()
            pickedUpEntries = entryController.entries
            
        }
        
        wait(for: [didFinish], timeout: 15)
        XCTAssertLessThan([EntryRepresentation]().count, pickedUpEntries.count)
        
    }
    
    func testSavingData() {
        
    }
    

    func testCallsToServer() throws {
        
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
