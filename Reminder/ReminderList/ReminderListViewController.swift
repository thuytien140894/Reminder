//
//  ReminderListViewController.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 10/20/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

class ReminderListViewController: UIViewController {

    private let presenter: ReminderListPresenterProtocol
    
    init(presenter: ReminderListPresenterProtocol) {
        
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        setupNavigationBar()
        setupUI()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        
        navigationItem.backBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(returnToHome))
    }
    
    @objc
    private func returnToHome() {
        
    }
}

extension ReminderListViewController: ViewControllerProtocol {
    
    func reloadView(with displayData: [Reminder]) {
        
    }
}
