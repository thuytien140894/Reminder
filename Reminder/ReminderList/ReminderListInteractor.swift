//
//  ReminderListInteractor.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 2/24/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

protocol ReminderListInteractorProtocol {
    func fetchReminders()
}

class ReminderListInteractor: ReminderListInteractorProtocol {
    
    private let dataManager: DataManagerProtocol
    var delegate: InteractorDelegate<Reminder>?
    
    init(dataManager: DataManagerProtocol) {
        
        self.dataManager = dataManager
    }
    
    func fetchReminders() {
        
        dataManager.fetchReminders() { [weak delegate] reminders in
            delegate?.fetched(displayData: reminders)
        }
    }
}
