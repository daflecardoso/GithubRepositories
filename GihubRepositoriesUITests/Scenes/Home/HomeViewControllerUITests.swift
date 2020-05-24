//
//  HomeViewControllerUITests.swift
//  GihubRepositoriesDafleCardosoUITests
//
//  Created by Dafle Cardoso on 16/05/20.
//  Copyright © 2020 Dafle Cardoso. All rights reserved.
//

import XCTest

class HomeViewControllerUITests: XCTestCase {
    
    private let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app.launchArguments = ["UITest"]
        app.launch()
    }

    override func tearDown() {
        super.tearDown()
    }

    func test_swipe_items_table_view() {
        let isDisplayingMain = app.otherElements["Main View"].exists
        
        XCTAssertTrue(isDisplayingMain)
        
        XCTAssertTrue(app.staticTexts["Repositórios"].exists)
        
        app.swipeDown()
        
        let searchBar = app.navigationBars.searchFields.firstMatch
        
        searchBar.tap()
        
        searchBar.typeText("Any string")
        
        searchBar.typeText("\n")
        
        app.tables.cells.staticTexts["FAKE DATA 1"].tap()

        sleep(3)
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        
        sleep(1)
    }
    
    func test_infity_scroll() {
        
        let searchBar = app.navigationBars.searchFields.firstMatch
        
        searchBar.tap()
        
        searchBar.typeText("This is UITest")
        
        searchBar.typeText("\n")
        
        sleep(2)
        
        XCTAssertEqual(app.tables.cells.count, 30)
        
        app.swipeUp()
        
        XCTAssertEqual(app.tables.cells.count, 60)
    }
}
