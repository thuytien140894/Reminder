//
//  MockWireFrame.swift
//  ReminderTests
//
//  Created by Tien Thuy Ho on 2/2/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

@testable import Reminder

class MockWireFrame: WireFrameProtocol {
    
    weak var presenter: PresenterProtocol?
    var currentlyDisplayedReminderListTitle = ""
    
    func showReminderDetailPage(withTitle title: String) {
        
        currentlyDisplayedReminderListTitle = title
    }
}
