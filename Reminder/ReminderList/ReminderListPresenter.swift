//
//  ReminderListPresenter.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 2/24/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import UIKit

protocol ReminderListPresenterProtocol {
    var reminderList: ReminderList { get set }
    func loadView()
    func goBackToHome()
}

class ReminderListPresenter: ReminderListPresenterProtocol {
    
    var reminderList: ReminderList = ReminderList(title: "")
    
    enum State {
        case initial
        case loading
        case loaded([Reminder])
        case error(Error)
    }
    
    var state: State = .initial {
        didSet {
            updateView()
        }
    }
    
    var viewControllerWrapper: ViewController<Reminder>?
    weak var viewController: ReminderListViewController?
    private let dataManager: DataManagerProtocol
    private let coordinator: CoordinatorProtocol
    
    init(dataManager: DataManagerProtocol, coordinator: CoordinatorProtocol) {
        
        self.dataManager = dataManager
        self.coordinator = coordinator
    }
    
    func loadView() {
        
        viewController?.title = reminderList.title
        
        state = .loading
        dataManager.fetchReminders(from: reminderList) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let reminders):
                self.state = .loaded(reminders)
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }
    
    func goBackToHome() {
        
        guard let viewController = viewController else { return }
        coordinator.goBackToHome(from: viewController)
    }
    
    private func updateView() {
        
        switch state {
        case .loaded(let reminders):
            viewControllerWrapper?.reloadView(with: reminders)
        default:
            return
        }
    }
}
