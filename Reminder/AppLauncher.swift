//
//  AppDependencies.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 10/27/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

protocol AppLauncherProtocol {
    func launch(for window: UIWindow?)
}

class AppLauncher {
    
    private var rootViewController: HomeViewController?
    
    init() {
        
        FirebaseApp.configure()
        configureDependencies()
    }
    
    private func configureDependencies() {
        
        let dataManager = setupDataManager()
        let homeInteractor = HomeInteractor(dataManager: dataManager)
        let homeWireFrame = HomeWireFrame()
        let homePresenter = HomePresenter(interactor: homeInteractor, wireframe: homeWireFrame)
        homeWireFrame.presenter = homePresenter
        rootViewController = HomeViewController(presenter: homePresenter)
        homePresenter.viewController = rootViewController
        homeInteractor.delegate = homePresenter
    }
    
    private func setupDataManager() -> HomeDataManager {
        
        var dataManager = HomeDataManager(database: Firestore.firestore())
        
        if uiTesting() {
            dataManager = HomeDataManager(database: MockFirestore())
            dataManager.addTestData()
        }
        
        return dataManager
    }
    
    private func uiTesting() -> Bool {
        
        return ProcessInfo.processInfo.arguments.contains("UI-TESTING")
    }
}

extension AppLauncher: AppLauncherProtocol {
    
    func launch(for window: UIWindow?) {
        
        installRootViewController(into: window)
        window?.makeKeyAndVisible()
    }
    
    func installRootViewController(into window: UIWindow?) {
        
        guard let viewController = rootViewController else { return }
        window?.rootViewController = UINavigationController(rootViewController: viewController)
    }
}
