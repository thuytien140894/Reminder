//
//  HomeDataManager.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import FirebaseFirestore

protocol DataManagerProtocol {
    func fetchReminderLists(completion: @escaping ([ReminderList]) -> Void)
    func fetchReminders(in reminderList: ReminderList, completion: (([Reminder]) -> Void)?)
    func addUser(_ user: ReminderUser)
    func addReminderList(_ reminderList: ReminderList)
    func addReminder(_ reminder: Reminder, to reminderList: ReminderList) -> String
    func removeReminderList(_ reminderList: ReminderList)
    func removeReminder(_ reminder: Reminder, from reminderList: ReminderList)
    func removeAllReminderLists()
    func removeAllReminders(from reminderList: ReminderList)
    func resetDatabase()
}

class HomeDataManager {
    
    var currentUser = ReminderUser(name: "Tien")
    private let database: FirestoreProtocol
    private var reminderListCollection: CollectionReference
    private var userCollection: CollectionReference
    
    init(database: FirestoreProtocol) {
        
        self.database = database
        let settings = database.settings
        settings.areTimestampsInSnapshotsEnabled = true
        self.database.settings = settings
        
        reminderListCollection = database.collection("reminderLists")
        userCollection = database.collection("users")
        
//        addTestData()
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
    
    func fetchReminderLists(completion: @escaping ([ReminderList]) -> Void) {
        
        let currentUserDocument = userCollection.document(currentUser.name)
        let reminderListCollection = getReminderLists(for: currentUserDocument)
        reminderListCollection.getDocuments { (querySnapshot, _) in
            guard let querySnapshot = querySnapshot else { return }
            let reminderLists = querySnapshot.documents.compactMap { ReminderList(jsonObject: $0.data()) }
            completion(reminderLists)
        }
    }
    
    func fetchReminders(in reminderList: ReminderList, completion: (([Reminder]) -> Void)? = nil) {
        
        let reminderListID = getID(for: reminderList)
        let reminderListDocument = reminderListCollection.document(reminderListID)
        let reminderCollection = getReminders(for: reminderListDocument)
        
        reminderCollection.getDocuments { (querySnapshot, _) in
            guard let querySnapshot = querySnapshot else { return }
            let reminders = querySnapshot.documents.compactMap { Reminder(jsonObject: $0.data()) }
            completion?(reminders)
        }
    }
    
    func addUser(_ user: ReminderUser) {
        
        let userDocument = userCollection.document(user.name)
        userDocument.setData([:])
        
        currentUser = user
    }
    
    func addReminderList(_ reminderList: ReminderList) {
        
        let userDocument = userCollection.document(currentUser.name)
        let reminderListCollection = getReminderLists(for: userDocument)
        let reminderListID = getID(for: reminderList)
        let reminderListDocument = reminderListCollection.document(reminderListID)
        reminderListDocument.setData(reminderList.jsonObject)
    }
    
    func removeReminderList(_ reminderList: ReminderList) {
        
        let reminderListID = getID(for: reminderList)
        removeReminderListFromUserCollection(documentID: reminderListID)
        removeReminderListFromReminderListCollection(documentID: reminderListID)
    }
    
    private func removeReminderListFromUserCollection(documentID: String) {
        
        let userDocument = userCollection.document(currentUser.name)
        let reminderListCollection = getReminderLists(for: userDocument)
        reminderListCollection.document(documentID).delete()
    }
    
    private func removeReminderListFromReminderListCollection(documentID: String) {
        
        reminderListCollection.document(documentID).delete()
    }
    
    func removeAllReminderLists() {
        
        let userDocument = userCollection.document(currentUser.name)
        let reminderListCollection = getReminderLists(for: userDocument)
        removeAllDocuments(from: reminderListCollection) { [weak self] documentIDs in
            documentIDs.forEach { self?.removeReminderListFromReminderListCollection(documentID: $0) }
        }
    }
    
    func addReminder(_ reminder: Reminder, to reminderList: ReminderList) -> String {
        
        let reminderListID = getID(for: reminderList)
        let reminderListDocument = reminderListCollection.document(reminderListID)
        reminderListDocument.setData([:])
        let reminderCollection = getReminders(for: reminderListDocument)
        let reminderDocument = reminderCollection.document()
        var jsonObject = reminder.jsonObject
        jsonObject["id"] = reminderDocument.documentID
        reminderDocument.setData(jsonObject)
        
        return reminderDocument.documentID
    }
    
    func removeReminder(_ reminder: Reminder, from reminderList: ReminderList) {
        
        let reminderListID = getID(for: reminderList)
        let reminderListDocument = reminderListCollection.document(reminderListID)
        let reminderCollection = getReminders(for: reminderListDocument)
        let reminderDocument = reminderCollection.document(reminder.identifier)
        reminderDocument.delete()
    }
    
    func removeAllReminders(from reminderList: ReminderList) {
        
        let reminderListID = getID(for: reminderList)
        let reminderListDocument = reminderListCollection.document(reminderListID)
        let reminderCollection = getReminders(for: reminderListDocument)
        removeAllDocuments(from: reminderCollection)
    }
    
    private func getReminders(for reminderListDocument: DocumentReference) -> CollectionReference {
        
        return reminderListDocument.collection("reminders")
    }
    
    private func getReminderLists(for userDocument: DocumentReference) -> CollectionReference {
        
        return userDocument.collection("reminderLists")
    }
    
    private func getID(for reminderList: ReminderList) -> String {
        
        return String(format: "%@-%@", currentUser.name, reminderList.title)
    }
    
    private func removeAllDocuments(from collection: CollectionReference, andSubcollection subcollectionName: String? = nil, completion: (([String]) -> Void)? = nil) {
        
        var documentIDs: [String] = []
        collection.getDocuments { (querySnapshot, _) in
            guard let querySnapshot = querySnapshot else { return }
            querySnapshot.documents.forEach { document in
                self.removeSubcollectionIfNecessary(subcollectionName, from: document.reference)
                documentIDs.append(document.documentID)
                document.reference.delete()
            }
            completion?(documentIDs)
        }
    }
    
    private func removeSubcollectionIfNecessary(_ subcollectionName: String?, from document: DocumentReference) {
        
        guard let subcollectionName = subcollectionName else { return }
        let subcollection = document.collection(subcollectionName)
        removeAllDocuments(from: subcollection)
    }
    
    func resetDatabase() {
        
        removeAllDocuments(from: userCollection, andSubcollection: "reminderLists")
        removeAllDocuments(from: reminderListCollection, andSubcollection: "reminders")
    }
}
