//
//  ReminderUITests.swift
//  ReminderUITests
//
//  Created by Tien Thuy Ho on 10/28/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import XCTest

class ReminderUITests: XCTestCase {
    
    private let homePageModel = HomePageModel()
    private let app = XCUIApplication()
    
    override func setUp() {
        
        super.setUp()
        
        app.launchArguments += ["UI-TESTING"]
        continueAfterFailure = false
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    func testSelectingReminderListShouldLaunchItsDetailsPage() {
        
        app.launch()
        
        let firstReminderList = homePageModel.reminderListCells.element(boundBy: 0)
        let reminderListTitle = homePageModel.titleForReminderList(at: 0).label
        firstReminderList.tap()
        
        XCTAssert(app.navigationBars[reminderListTitle].exists)
    }
    
    func testSwipingLeftShouldGoToTheNextReminderList() {
        
        app.launch()
        
        XCTAssertEqual(homePageModel.pageControlValue, "page 1 of 3")
        homePageModel.reminderListCollection.swipeLeft()
        
        XCTAssertEqual(homePageModel.pageControlValue, "page 2 of 3")
    }
    
    func testSwipingRightShouldGoBackToThePreviousReminderList() {
        
        app.launch()
        
        homePageModel.reminderListCollection.swipeLeft()
        XCTAssertEqual(homePageModel.pageControlValue, "page 2 of 3")
        
        homePageModel.reminderListCollection.swipeRight()
        XCTAssertEqual(homePageModel.pageControlValue, "page 1 of 3")
    }
}
