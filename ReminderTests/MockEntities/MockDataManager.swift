//
//  MockDataManager.swift
//  ReminderTests
//
//  Created by Tien Thuy Ho on 2/2/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

@testable import Reminder

class MockDataManager: DataManagerProtocol {
    
    var reminderLists: [ReminderList] = []
    var currentUser = ReminderUser(name: "Someone")
    var reminders: [Reminder] = []
    
    init() {
        
        reminderLists.append(ReminderList(title: "Home"))
    }
    
    func fetchReminderLists(completion: @escaping ([ReminderList]) -> Void) {
        
        completion(reminderLists)
    }
    
    func fetchReminders(in reminderList: ReminderList) {}
    
    func addUser(_ user: ReminderUser) {
        
        currentUser = user
    }
    
    func addReminderList(_ reminderList: ReminderList) {
        
        reminderLists.append(reminderList)
    }
    
    func addReminder(_ reminder: Reminder, to reminderList: ReminderList) {

        reminders.append(reminder)
    }
}
