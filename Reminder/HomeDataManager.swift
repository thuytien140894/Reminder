//
//  HomeDataManager.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

protocol DataManagerProtocol {
    func fetchReminderLists(completion: @escaping ([ReminderList]) -> ())
    func fetchReminders(in reminderList: ReminderList)
    func addUser(_ user: ReminderUser)
    func addReminderList(_ reminderList: ReminderList)
    func addReminder(_ reminder: Reminder, to reminderList: ReminderList)
}

class HomeDataManager {
    
    static var currentUser = ReminderUser(name: "Tien")
    
    init() {
        
    }
}

extension HomeDataManager: DataManagerProtocol {
    
    func fetchReminderLists(completion: @escaping ([ReminderList]) -> ()) {
    
    }
    
    func fetchReminders(in reminderList: ReminderList) {

    }
    
    func addUser(_ user: ReminderUser) {
        
    }

    func addReminderList(_ reminderList: ReminderList) {

    }
    
    func addReminder(_ reminder: Reminder, to reminderList: ReminderList) {

    }
}
