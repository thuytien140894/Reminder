//
//  AppCoordinator.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 10/27/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit
import FirebaseFirestore

protocol AppLaunching {
    func launch(for window: UIWindow?)
}

protocol ViewControllerConfiguring: class {
    func configureHomeViewController() -> UIViewController
    func configureReminderListViewController(with reminderList: ReminderList) -> UIViewController
}

class AppCoordinator {
    
    private weak var coordinator: CoordinatorProtocol?
    private lazy var dataManager: DataManager = {
        setupDataManager()
    }()
    
    init() {
        
        coordinator = Coordinator(appConfigurer: self)
    }
    
    private func setupDataManager() -> DataManager {
        
        var dataManager = DataManager(database: Firestore.firestore())
        
        if uiTesting() {
            dataManager = DataManager(database: MockFirestore())
            dataManager.addTestData()
        }
        
        return dataManager
    }
    
    private func uiTesting() -> Bool {
        
        return ProcessInfo.processInfo.arguments.contains("UI-TESTING")
    }
}

extension AppCoordinator: ViewControllerConfiguring {
    
    func configureHomeViewController() -> UIViewController {
        
        let presenter = HomePresenter(dataManager: dataManager, coordinator: coordinator ?? Coordinator(appConfigurer: self))
        let viewController = HomeViewController(presenter: presenter)
        presenter.viewControllerWrapper = ViewController(viewController)
        
        return viewController
    }
    
    func configureReminderListViewController(with reminderList: ReminderList) -> UIViewController {
        
        let presenter = ReminderListPresenter(dataManager: dataManager, coordinator: coordinator ?? Coordinator(appConfigurer: self))
        let viewController = ReminderListViewController(presenter: presenter)
        presenter.reminderList = reminderList
        presenter.viewController = viewController
        presenter.viewControllerWrapper = ViewController(viewController)
        
        return viewController
    }
}

extension AppCoordinator: AppLaunching {
    
    func launch(for window: UIWindow?) {
        
        let homeViewController = configureHomeViewController()
        installRootViewController(homeViewController, into: window)
    }
    
    private func installRootViewController(_ viewController: UIViewController, into window: UIWindow?) {
        
        window?.rootViewController = UINavigationController(rootViewController: viewController)
        window?.makeKeyAndVisible()
    }
}
