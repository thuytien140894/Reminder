//
//  AppDependencies.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/27/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit
import Firebase

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
        
        let dataManager = HomeDataManager()
        let homeInteractor = HomeInteractor(dataManager: dataManager)
        let homeWireFrame = HomeWireFrame()
        let homePresenter = HomePresenter(interactor: homeInteractor, wireframe: homeWireFrame)
        homeWireFrame.presenter = homePresenter
        rootViewController = HomeViewController(presenter: homePresenter)
        homePresenter.viewController = rootViewController
        homeInteractor.delegate = homePresenter
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
