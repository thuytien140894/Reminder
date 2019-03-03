//
//  Interactor.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

protocol HomeInteractorProtocol: class {
    func fetchReminderLists()
    func setCurrentReminderList(_ reminderList: ReminderList)
}

class HomeInteractor: HomeInteractorProtocol {

    private let dataManager: DataManagerProtocol
    var delegate: InteractorDelegate<ReminderList>?
    
    init(dataManager: DataManagerProtocol) {
        
        self.dataManager = dataManager
    }
    
    func fetchReminderLists() {
        
        dataManager.fetchReminderLists { [weak delegate] reminders in
            delegate?.fetched(displayData: reminders)
        }
    }
    
    func setCurrentReminderList(_ reminderList: ReminderList) {
        
        dataManager.setCurrentReminderList(reminderList)
    }
}
