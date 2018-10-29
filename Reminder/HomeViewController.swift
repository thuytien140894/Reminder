//
//  HomeViewController.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

protocol ViewControllerProtocol: class {
    func reloadView(with displayData: [ReminderList])
}

class HomeViewController: VerticalCollectionViewController {

    public var presenter: PresenterProtocol
    
    init(presenter: PresenterProtocol) {
        
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        presenter.loadView()
    }
}

extension HomeViewController: ViewControllerProtocol {
    
    func reloadView(with displayData: [ReminderList]) {
        
        print(displayData)
    }
}
