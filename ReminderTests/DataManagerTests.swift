//
//  DataManagerTests.swift
//  ReminderTests
//
//  Created by Tien Thuy Ho on 2/2/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import XCTest
@testable import Reminder

class DataManagerTests: XCTestCase {
    
    private let dataManager = DataManager(database: MockFirestore())
    
    override func tearDown() {
        
        dataManager.resetDatabase()
        
        super.tearDown()
    }
    
    func testFetchingReminderLists() {
        
        let addedReminderLists = addSomeReminderLists()

        let completionBlock: (Result<[ReminderList], NetworkError>) -> Void = { result in
            guard let reminderLists = self.unwrapSuccess(result: result) else {
                return XCTFail("Error is thrown.")
            }
            XCTAssert(addedReminderLists.elementsEqual(reminderLists))
        }
        dataManager.fetchReminderLists(completion: completionBlock)
    }
    
    func testAddingReminderList() {
        
        dataManager.addUser(ReminderUser(name: "Tien"))
        let reminderListToAdd = ReminderList(title: "Reminder List")
        dataManager.addReminderList(reminderListToAdd)
        
        let completionBlock: (Result<[ReminderList], NetworkError>) -> Void = { result in
            guard let reminderLists = self.unwrapSuccess(result: result) else {
                return XCTFail("Error is thrown.")
            }
            XCTAssert(reminderLists.contains(reminderListToAdd))
        }
        dataManager.fetchReminderLists(completion: completionBlock)
    }
    
    func testRemovingReminderList() {
        
        let addedReminderLists = addSomeReminderLists()
        let reminderListToRemove = addedReminderLists[0]
        dataManager.removeReminderList(reminderListToRemove)
        
        let completionBlock: (Result<[ReminderList], NetworkError>) -> Void = { result in
            guard let reminderLists = self.unwrapSuccess(result: result) else {
                return XCTFail("Error is thrown.")
            }
            XCTAssert(addedReminderLists.contains(where: reminderLists.contains))
            XCTAssertFalse(reminderLists.contains(reminderListToRemove))
        }
        dataManager.fetchReminderLists(completion: completionBlock)
    }
    
    func testRemovingAllReminderLists() {
        
        addSomeReminderLists()
        dataManager.removeAllReminderLists()
    
        let completionBlock: (Result<[ReminderList], NetworkError>) -> Void = { result in
            guard let reminderLists = self.unwrapSuccess(result: result) else {
                return XCTFail("Error is thrown.")
            }
            XCTAssertEqual(reminderLists.count, 0)
        }
        dataManager.fetchReminderLists(completion: completionBlock)
    }
    
    @discardableResult
    private func addSomeReminderLists() -> [ReminderList] {
        
        dataManager.addUser(ReminderUser(name: "Tien"))
        
        let reminderLists = [ReminderList(title: "Home"),
                             ReminderList(title: "Work"),
                             ReminderList(title: "Garden")]
        reminderLists.forEach { dataManager.addReminderList($0) }
        return reminderLists
    }
    
    func testFetchingReminders() {
        
        let addedReminders = addSomeReminders()
        
        let completionBlock: (Result<[Reminder], NetworkError>) -> Void = { result in
            guard let reminders = self.unwrapSuccess(result: result) else {
                return XCTFail("Error is thrown.")
            }
            XCTAssert(addedReminders.elementsEqual(reminders))
        }
        dataManager.fetchReminders(from: ReminderList(title: "Home"), completion: completionBlock)
    }
    
    func testRemovingReminder() {
        
        let addedReminders = addSomeReminders()
        let reminderToRemove = addedReminders[0]
        let reminderList = ReminderList(title: "Home")
        dataManager.removeReminder(reminderToRemove, from: reminderList)
        
        let completionBlock: (Result<[Reminder], NetworkError>) -> Void = { result in
            guard let reminders = self.unwrapSuccess(result: result) else {
                return XCTFail("Error is thrown.")
            }
            XCTAssert(addedReminders.contains(where: reminders.contains))
            XCTAssertFalse(reminders.contains(reminderToRemove))
        }
        dataManager.fetchReminders(from: reminderList, completion: completionBlock)
    }
    
    func testRemovingAllRemindersFromCurrentReminderList() {
        
        addSomeReminders()
        let reminderList = ReminderList(title: "Home")
        dataManager.removeAllReminders(from: reminderList)
        
        let completionBlock: (Result<[Reminder], NetworkError>) -> Void = { result in
            guard let reminders = self.unwrapSuccess(result: result) else {
                return XCTFail("Error is thrown.")
            }
            XCTAssertEqual(reminders.count, 0)
        }
        dataManager.fetchReminders(from: reminderList, completion: completionBlock)
    }
    
    @discardableResult
    private func addSomeReminders() -> [Reminder] {
        
        var reminder1 = Reminder(
            content: "Feed the cat",
            deadline: "123",
            isCompleted: false,
            identifier: ""
        )
        
        var reminder2 = Reminder(
            content: "Go to gym",
            deadline: "123",
            isCompleted: false,
            identifier: ""
        )
        
        reminder1.identifier = dataManager.addReminder(reminder1, to: ReminderList(title: "Home"))
        reminder2.identifier = dataManager.addReminder(reminder2, to: ReminderList(title: "Home"))
        
        return [reminder1, reminder2]
    }
    
    private func unwrapSuccess<T, E: Error>(result: Result<T, E>) -> T? {
        
        switch result {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
}
