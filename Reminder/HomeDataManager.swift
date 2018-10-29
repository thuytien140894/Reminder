//
//  HomeDataManager.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import FirebaseFirestore

protocol DataManagerProtocol {
    func fetchReminderLists(completion: @escaping ([ReminderList]) -> ())
    func fetchReminders(in reminderList: ReminderList)
    func addUser(_ user: ReminderUser)
    func addReminderList(_ reminderList: ReminderList)
    func addReminder(_ reminder: Reminder, to reminderList: ReminderList)
}

class HomeDataManager {
    
    static var currentUser = ReminderUser(name: "Tien")
    private let database = Firestore.firestore()
    private var reminderListCollection: CollectionReference
    private var userCollection: CollectionReference
    
    init() {
        
        reminderListCollection = database.collection("reminderLists")
        userCollection = database.collection("users")
        
//        addTestData()
        fetchReminders(in: ReminderList(title: "Home"))
    }
    
    private func addTestData() {
        
        addUser(ReminderUser(name: "Tien"))
        addReminderList(ReminderList(title: "Home"))
        addReminderList(ReminderList(title: "Work"))
        addReminderList(ReminderList(title: "Garden"))
        
        let reminder = Reminder(
            content: "Feed the cat",
            deadline: "123",
            isCompleted: false
        )
        addReminder(reminder, to: ReminderList(title: "Home"))
    }
}

extension HomeDataManager: DataManagerProtocol {
    
    func fetchReminderLists(completion: @escaping ([ReminderList]) -> ()) {
        
        let currentUserName = HomeDataManager.currentUser.name
        let currentUserDocument = userCollection.document(currentUserName)
        let reminderListCollection = getReminderLists(for: currentUserDocument)
        reminderListCollection.getDocuments { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else { return }
            
            let reminderLists = querySnapshot.documents.compactMap { document in
                return ReminderList(jsonObject: document.data())
            }
            
            completion(reminderLists)
        }
    }
    
    func fetchReminders(in reminderList: ReminderList) {
        
        let reminderListID = getID(for: reminderList)
        let reminderListDocument = reminderListCollection.document(reminderListID)
        let reminderCollection = getReminders(for: reminderListDocument)
        
        reminderCollection.getDocuments { (querySnapshot, error) in
            guard let querySnapshot = querySnapshot else { return }
            
            let reminders = querySnapshot.documents.map { document in
                return Reminder(jsonObject: document.data())
            }
            print(reminders)
        }
    }
    
    func addUser(_ user: ReminderUser) {
        
        let userDocument = userCollection.document(user.name)
        userDocument.setData(["name": user.name])
        
        HomeDataManager.currentUser = user
    }
    
    func addReminderList(_ reminderList: ReminderList) {
        
        let user = HomeDataManager.currentUser
        let userDocument = userCollection.document(user.name)
        let reminderListID = getID(for: reminderList)
        let reminderListCollection = getReminderLists(for: userDocument)
        let reminderListDocument = reminderListCollection.document(reminderListID)
        reminderListDocument.setData(["title": reminderList.title])
    }
    
    func addReminder(_ reminder: Reminder, to reminderList: ReminderList) {
        
        let reminderListID = getID(for: reminderList)
        let reminderListDocument = reminderListCollection.document(reminderListID)
        let reminderCollection = getReminders(for: reminderListDocument)
        reminderCollection.addDocument(data: reminder.jsonObject)
    }
    
    private func getReminders(for reminderListDocument: DocumentReference) -> CollectionReference {
        
        return reminderListDocument.collection("reminders")
    }
    
    private func getReminderLists(for userDocument: DocumentReference) -> CollectionReference {
        
        return userDocument.collection("reminderLists")
    }
    
    private func getID(for reminderList: ReminderList) -> String {
        
        return String(format: "%@-%@", HomeDataManager.currentUser.name, reminderList.title)
    }
}
