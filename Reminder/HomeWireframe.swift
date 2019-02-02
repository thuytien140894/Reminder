//
//  HomeWireframe.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

protocol WireFrameProtocol {
    func showReminderDetailPage(withTitle title: String)
}

class HomeWireFrame: WireFrameProtocol {
    
    weak var presenter: PresenterProtocol?
    var navigationController: UINavigationController? {
        guard
            let viewController = presenter?.viewController as? UIViewController,
            let navigationController = viewController.navigationController else { return nil }
        return navigationController
    }
    
    func showReminderDetailPage(withTitle title: String) {
        
        let reminderDetailViewController = ReminderDetailViewController()
        reminderDetailViewController.title = title
        navigationController?.pushViewController(reminderDetailViewController, animated: true)
    }
}
