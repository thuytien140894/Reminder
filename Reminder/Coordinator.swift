//
//  Coordinator.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

protocol CoordinatorProtocol: class {
    func showReminderList(_ reminderList: ReminderList, from viewController: UIViewController)
    func goBackToHome(from viewController: UIViewController)
}

class Coordinator: CoordinatorProtocol {
    
    private let appConfigurer: ViewControllerConfiguring
    
    init(appConfigurer: ViewControllerConfiguring) {
        
        self.appConfigurer = appConfigurer
    }
    
    func showReminderList(_ reminderList: ReminderList, from viewController: UIViewController) {
        
        let reminderListViewController = appConfigurer.configureReminderListViewController(with: reminderList)
        let navigationController = UINavigationController(rootViewController: reminderListViewController)
        viewController.present(navigationController, animated: true)
    }
    
    func goBackToHome(from viewController: UIViewController) {
        
        viewController.dismiss(animated: true, completion: nil)
    }
}
