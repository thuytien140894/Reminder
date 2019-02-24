//
//  MockHomeView.swift
//  ReminderTests
//
//  Created by Tien Thuy Ho on 2/19/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

@testable import Reminder

class MockHomeViewController: ViewControllerProtocol {
    
    var displayDataModels: [ReminderList] = []
    
    func reloadView(with displayData: [ReminderList]) {
        
        displayDataModels = displayData
    }
}
