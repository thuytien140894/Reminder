//
//  ReminderTests.swift
//  ReminderTests
//
//  Created by Tien Thuy Ho on 10/28/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import XCTest
@testable import Reminder

class ReminderTests: XCTestCase {

    private var homeViewController: HomeViewController!
    private var homeWireFrame: MockWireFrame!
    private var dataManager: MockDataManager!
    
    override func setUp() {
        
        super.setUp()
        
        dataManager = MockDataManager()
        let homeInteractor = HomeInteractor(dataManager: dataManager)
        homeWireFrame = MockWireFrame()
        let homePresenter = HomePresenter(interactor: homeInteractor, wireframe: homeWireFrame)
        homeWireFrame.presenter = homePresenter
        homeViewController = HomeViewController(presenter: homePresenter)
        homePresenter.viewController = homeViewController
        homeInteractor.delegate = homePresenter
    }

    override func tearDown() {
        
        homeViewController = nil
        homeWireFrame = nil
        dataManager = nil
        
        super.tearDown()
    }
    
    func testSelectingReminderListShouldLaunchReminderDetailPage() {
        
        homeViewController?.viewDidLoad()
        homeViewController?.selectItem(at: 0)
        guard let homeWireFrame = homeWireFrame else { return }
        let firstReminderListTitle = dataManager.reminderLists[0].title
        XCTAssertEqual(homeWireFrame.currentlyDisplayedReminderListTitle, firstReminderListTitle)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
