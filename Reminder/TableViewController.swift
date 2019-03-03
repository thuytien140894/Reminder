//
//  TableViewController.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 3/2/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        return UITableView(frame: view.frame)
    }()
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension TableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return ReminderCell()
    }
}

extension TableViewController: UITableViewDelegate {
    
}
