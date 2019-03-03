//
//  HomePageModel.swift
//  ReminderTests
//
//  Created by Tien Thuy Ho on 2/19/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import XCTest

class HomePageModel {
    
    private let app = XCUIApplication()
    
    private struct ElementLocator {
        static let reminderListCollectionID = "reminderListCollection"
        static let reminderListCellID = "reminderListCell"
        static let reminderlistTitleID = "reminderListTitle"
        static let pageControlID = "pageControl"
    }
    
    var reminderListCollection: XCUIElement {
        
        return app.otherElements[ElementLocator.reminderListCollectionID]
    }
    
    var reminderListCells: XCUIElementQuery {
        return app.cells.matching(identifier: ElementLocator.reminderListCellID)
    }
    
    var pageControl: XCUIElement {
        return app.pageIndicators[ElementLocator.pageControlID]
    }
    
    var pageControlValue: String {
        guard let value = pageControl.value as? String else {
            XCTFail("Cannot access page control value.")
            return ""
        }
        
        return value
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
