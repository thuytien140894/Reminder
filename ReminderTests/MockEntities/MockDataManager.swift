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
    
    var reminderLists: [ReminderList] = []
    var currentUser = ReminderUser(name: "Someone")
    var reminders: [Reminder] = []
    
    func fetchReminderLists(completion: @escaping ([ReminderList]) -> Void) {
        
        completion(reminderLists)
    }
    
    func fetchReminders(in reminderList: ReminderList, completion: (([Reminder]) -> Void)? = nil) {}
    
    func addUser(_ user: ReminderUser) {
        
        currentUser = user
    }
    
    func addReminderList(_ reminderList: ReminderList) {
        
        reminderLists.append(reminderList)
    }
    
    func addReminder(_ reminder: Reminder, to reminderList: ReminderList) -> String {

        reminders.append(reminder)
        return UUID().uuidString
    }
    
    func removeReminderList(_ reminderList: ReminderList) {
        
        reminderLists = reminderLists.filter { $0 != reminderList }
    }
    
    func removeReminder(_ reminder: Reminder, from reminderList: ReminderList) {
        
        reminders = reminders.filter { $0 != reminder }
    }
    
    func removeAllReminderLists() {
    
        reminderLists.removeAll()
    }
    
    func removeAllReminders(from reminderList: ReminderList) {
        
        reminders.removeAll()
    }
    
    func resetDatabase() {
        
        reminderLists.removeAll()
        reminders.removeAll()
    }
}
