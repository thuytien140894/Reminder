//
//  AppCoordinatorTests.swift
//  ReminderTests
//
//  Created by Tien Thuy Ho on 2/26/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import XCTest
@testable import Reminder

class AppCoordinatorTests: XCTestCase {
    
    private let appCoordinator = AppCoordinator()
    
    func testConfiguringHomeViewController() {
        
        let viewController = appCoordinator.configureHomeViewController()
        XCTAssertNotNil(viewController)
    }
    
    func testConfiguringReminderListViewController() {
        
        let viewController = appCoordinator.configureReminderListViewController()
        XCTAssertNotNil(viewController)
    }
    
    func testAppShouldFirstLaunchHomeViewController() {
        
        let window = UIWindow()
        appCoordinator.launch(for: window)
        XCTAssertNotNil(window.rootViewController)
        XCTAssert(window.isKeyWindow)
       
        guard let navigationController = window.rootViewController as? UINavigationController else {
                XCTFail("Root view controller should be a navigation controller.")
                return
        }
        
        XCTAssertGreaterThan(navigationController.viewControllers.count, 0)
        let rootViewController = navigationController.viewControllers[0]
        XCTAssert(rootViewController is HomeViewController)
    }
}
