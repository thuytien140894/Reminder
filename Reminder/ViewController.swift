//
//  ViewController.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 2/24/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//  Type erasure: https://medium.com/@chris_dus/type-erasure-in-swift-84480c807534
//

import UIKit

protocol ViewControllerProtocol: class {
    associatedtype DisplayObject: Displayable
    func reloadView(with displayData: [DisplayObject])
}

class ViewController<T: Displayable>: ViewControllerProtocol {
    
    private weak var viewController: UIViewController?
    private let _reloadView: (_ displayData: [T]) -> Void
    
    init<U: ViewControllerProtocol>(_ viewController: U) where U.DisplayObject == T {
        
        _reloadView = viewController.reloadView
        
        if let viewController = viewController as? UIViewController {
            self.viewController = viewController
        }
    }
    
    func reloadView(with displayData: [T]) {
        
        return _reloadView(displayData)
    }
    
    func unwrap() -> UIViewController? {
        
        return viewController
    }
}
