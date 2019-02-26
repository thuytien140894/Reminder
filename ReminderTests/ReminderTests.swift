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
    
    private var homeViewController: MockHomeViewController!
    private var homePresenter: HomePresenter!
    private var homeWireFrame: MockWireFrame!
    private var dataManager: MockDataManager!
    
    override func setUp() {
        
        super.setUp()
        
        dataManager = MockDataManager()
        let homeInteractor = HomeInteractor(dataManager: dataManager)
        homeWireFrame = MockWireFrame()
        homePresenter = HomePresenter(interactor: homeInteractor, wireframe: homeWireFrame)
        homeViewController = MockHomeViewController()
        homePresenter.viewControllerWrapper = ViewController(homeViewController)
        homeInteractor.delegate = InteractorDelegate(homePresenter)
    }
    
    override func tearDown() {
        
        homeViewController = nil
        homePresenter = nil
        homeWireFrame = nil
        dataManager = nil
        
        super.tearDown()
    }
    
    func testReloadingViewControllerDisplayModelsFromDatabase() {
        
        let addedReminderLists = addReminderListsToDatabase()
        
        homePresenter.loadView()
        XCTAssert(homeViewController.displayDataModels.elementsEqual(addedReminderLists))
    }
    
    func testSelectingReminderListShouldNavigateToIt() {
        
        let addedReminderLists = addReminderListsToDatabase()
        
        homePresenter.loadView()
        let selectedIndex = Int.random(in: 0..<addedReminderLists.count)
        homePresenter.selectReminderList(at: selectedIndex)
        XCTAssert(homeWireFrame.reminderDetailPageIsShown)
    }
    
    private func addReminderListsToDatabase() -> [ReminderList] {
        
        let reminderLists = [ReminderList(title: "Home"),
                             ReminderList(title: "Work"),
                             ReminderList(title: "Garden")]
        reminderLists.forEach { dataManager.addReminderList($0) }
        return reminderLists
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
