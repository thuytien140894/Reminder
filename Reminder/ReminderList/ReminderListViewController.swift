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
        
        presenter.loadView()
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
    }
    
    private func setupNavigationBar() {
        
        let dismissButtonIcon = UIImage(named: "dismiss_button", in: Bundle(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: dismissButtonIcon, style: .plain, target: self, action: #selector(didCancel))
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
    }
    
    @objc
    private func didCancel() {
    
        presenter.goBackToHome()
    }
}

extension ReminderListViewController: ViewControllerProtocol {
    
    func reloadView(with displayData: [Reminder]) {
        
    }
}
