//
//  AppDependencies.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/27/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

protocol AppLauncherProtocol {
    func launch(for window: UIWindow?)
}

class AppLauncher {
    
    private var rootViewController: HomeViewController?
    
    init() {
        
        configureDependencies()
    }
    
    private func configureDependencies() {
        
        let homePresenter = HomePresenter()
        rootViewController = HomeViewController(presenter: homePresenter)
        homePresenter.viewController = rootViewController
        rootViewController?.presenter = homePresenter
        let dataManager = HomeDataManager()
        let homeInteractor = HomeInteractor(dataManager: dataManager)
        homeInteractor.delegate = homePresenter
        homePresenter.interactor = homeInteractor
    }
}

extension AppLauncher: AppLauncherProtocol {
    
    func launch(for window: UIWindow?) {
        
        installRootViewController(into: window)
        display(window: window)
    }
    
    func installRootViewController(into window: UIWindow?) {
        
        guard let viewController = rootViewController else { return }
        window?.rootViewController = UINavigationController(rootViewController: viewController)
    }
    
    func display(window: UIWindow?) {
        
        window?.makeKeyAndVisible()
    }
}
