//
//  ReminderListWireframe.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 2/25/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import UIKit

protocol ReminderListWireFrameProtocol {
    func goBackToHome(from viewController: UIViewController)
}

class ReminderListWireframe: ReminderListWireFrameProtocol {
    
    private let appCoordinator: ViewControllerConfiguring
    
    init(appCoordinator: ViewControllerConfiguring) {
        
        self.appCoordinator = appCoordinator
    }
    
    func goBackToHome(from viewController: UIViewController) {
        
        viewController.dismiss(animated: true, completion: nil)
    }
}
