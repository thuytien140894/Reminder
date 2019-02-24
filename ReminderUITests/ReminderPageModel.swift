//
//  ReminderPageModel.swift
//  ReminderTests
//
//  Created by Tien Thuy Ho on 2/19/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import XCTest

class ReminderPageModel {
    
    private let app = XCUIApplication()
    
    private struct ElementLocator {
        static let reminderListCellID = "reminderListCell"
        static let reminderlistTitleID = "reminderListTitle"
    }
    
    var reminderListCells: XCUIElementQuery {
        return app.cells.matching(identifier: ElementLocator.reminderListCellID)
    }
    
    func titleForReminderList(at index: Int) -> XCUIElement {
        
        let reminderList = reminderListCells.element(boundBy: index)
        return reminderList.staticTexts[ElementLocator.reminderlistTitleID]
    }
    
    func selectReminderListCell(at index: Int) {
        
        XCTAssertLessThan(index, reminderListCells.count, "Index is out of bound.")
        let cellToSelect = reminderListCells.element(boundBy: index)
        cellToSelect.tap()
    }
}
