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

protocol ViewControllerConfiguring {
    func configureHomeViewController() -> UIViewController
    func configureReminderListViewController() -> UIViewController
}

class AppCoordinator {
    
    private lazy var dataManager: DataManager = {
        setupDataManager()
    }()
    
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
        
        let interactor = HomeInteractor(dataManager: dataManager)
        let wireframe = HomeWireFrame(appCoordinator: self)
        let presenter = HomePresenter(interactor: interactor, wireframe: wireframe)
        let viewController = HomeViewController(presenter: presenter)
        presenter.viewControllerWrapper = ViewController(viewController)
        interactor.delegate = InteractorDelegate(presenter)
        
        return viewController
    }
    
    func configureReminderListViewController() -> UIViewController {
        
        let interactor = ReminderListInteractor(dataManager: dataManager)
        let wireframe = ReminderListWireframe(appCoordinator: self)
        let presenter = ReminderListPresenter(interactor: interactor, wireframe: wireframe)
        let viewController = ReminderListViewController(presenter: presenter)
        presenter.viewControllerWrapper = ViewController(viewController)
        interactor.delegate = InteractorDelegate(presenter)
        
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
