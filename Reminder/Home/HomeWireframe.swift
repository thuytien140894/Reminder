//
//  HomeWireframe.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

protocol WireFrameProtocol {
    func showReminderDetailPage(from viewController: UIViewController)
}

class HomeWireFrame: WireFrameProtocol {
    
    private let appCoordinator: ViewControllerConfiguring
    
    init(appCoordinator: ViewControllerConfiguring) {
        
        self.appCoordinator = appCoordinator
    }
    
    func showReminderDetailPage(from viewController: UIViewController) {
        
        let reminderListViewController = appCoordinator.configureReminderListViewController()
        let navigationController = UINavigationController(rootViewController: reminderListViewController)
        viewController.present(navigationController, animated: true)
    }
}
