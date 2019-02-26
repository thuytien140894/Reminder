//
//  MockHomeView.swift
//  ReminderTests
//
//  Created by Tien Thuy Ho on 2/19/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import UIKit 
@testable import Reminder

class MockHomeViewController: UIViewController {
    
    var displayDataModels: [ReminderList] = []
}

extension MockHomeViewController: ViewControllerProtocol {
    
    func reloadView(with displayData: [ReminderList]) {
        
        displayDataModels = displayData
    }
}
