//
//  ReminderDetailViewController.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 10/20/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

class ReminderDetailViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupNavigationBar()
        setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {}
}
