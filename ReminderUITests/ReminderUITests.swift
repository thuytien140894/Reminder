//
//  ReminderUITests.swift
//  ReminderUITests
//
//  Created by Tien Thuy Ho on 10/28/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import XCTest

class ReminderUITests: XCTestCase {
    
    private let reminderPageModel = ReminderPageModel()
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
        
        let firstReminderList = reminderPageModel.reminderListCells.element(boundBy: 0)
        let reminderListTitle = reminderPageModel.titleForReminderList(at: 0).label
        firstReminderList.tap()
        
        XCTAssert(app.navigationBars[reminderListTitle].exists)
    }
}
