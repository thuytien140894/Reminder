//
//  HomeInteractor.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

protocol InteractorProtocol: class {
    func fetchReminderLists()
}

class HomeInteractor: InteractorProtocol {

    private let dataManager: DataManagerProtocol
    weak var delegate: InteractorDelegateProtocol?
    
    init(dataManager: DataManagerProtocol) {
        
        self.dataManager = dataManager
    }
    
    func fetchReminderLists() {
        
        dataManager.fetchReminderLists { [weak delegate] reminderLists in
            delegate?.fetched(reminderLists: reminderLists)
        }
    }
}
