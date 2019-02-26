//
//  MockDataManager.swift
//  ReminderTests
//
//  Created by Tien Thuy Ho on 2/2/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import Foundation
@testable import Reminder

class MockDataManager: DataManagerProtocol {
    
    private var reminderLists: [ReminderList] = []
    private var currentUser = ReminderUser(name: "Someone")
    private var reminders: [Reminder] = []
    private var currentReminderList: ReminderList?
    
    func fetchReminderLists(completion: @escaping ([ReminderList]) -> Void) {
        
        completion(reminderLists)
    }
    
    func fetchReminders(completion: (([Reminder]) -> Void)? = nil) {
        
        completion?(reminders)
    }
    
    func addUser(_ user: ReminderUser) {
        
        currentUser = user
    }
    
    func addReminderList(_ reminderList: ReminderList) {
        
        reminderLists.append(reminderList)
    }
    
    func addReminder(_ reminder: Reminder) -> String {

        reminders.append(reminder)
        return UUID().uuidString
    }
    
    func removeReminderList(_ reminderList: ReminderList) {
        
        reminderLists = reminderLists.filter { $0 != reminderList }
    }
    
    func removeReminder(_ reminder: Reminder) {
        
        reminders = reminders.filter { $0 != reminder }
    }
    
    func removeAllReminderLists() {
    
        reminderLists.removeAll()
    }
    
    func removeAllReminders(from reminderList: ReminderList) {
        
        var matchedReminderList = reminderLists.first { $0 == reminderList}
        matchedReminderList?.reset()
    }
    
    func removeAllReminders() {
        
        reminders.removeAll()
        currentReminderList?.reset()
    }
    
    func resetDatabase() {
        
        reminderLists.removeAll()
        reminders.removeAll()
    }
    
    func setCurrentReminderList(_ reminderList: ReminderList) {
        
        currentReminderList = reminderList
    }
}
