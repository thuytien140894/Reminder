//
//  MockHomeWireFrame.swift
//  ReminderTests
//
//  Created by Tien Thuy Ho on 2/2/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import UIKit 
@testable import Reminder

class MockHomeWireFrame: HomeWireFrameProtocol {
    
    var reminderDetailPageIsShown = false
    
    func showReminderDetailPage(from viewController: UIViewController) {
        
        reminderDetailPageIsShown = true
    }
}
