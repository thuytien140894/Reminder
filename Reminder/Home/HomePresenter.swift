//
//  HomePresenter.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

protocol ViewRenderable: class {
    var state: HomePresenter.State { get set }
}

protocol HomePresenterProtocol: ViewRenderable {
    func loadView()
}

class HomePresenter: HomePresenterProtocol, ViewRenderable {
    
    enum State {
        case initial
        case loading
        case loaded([ReminderList])
        case select(Int)
        case error(Error)
    }
    
    var state: State = .initial {
        didSet {
            updateView()
        }
    }
    
    var viewControllerWrapper: ViewController<ReminderList>?
    private let dataManager: DataManagerProtocol
    private let coordinator: CoordinatorProtocol
    private var reminderLists: [ReminderList] = []
    
    init(dataManager: DataManagerProtocol, coordinator: CoordinatorProtocol) {
        
        self.dataManager = dataManager
        self.coordinator = coordinator
    }
    
    func loadView() {
        
        state = .loading
        dataManager.fetchReminderLists { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let reminderLists):
                self.state = .loaded(reminderLists)
            case .failure(let error):
                self.state = .error(error)
            }
        }
    }
    
    private func updateView() {
        
        switch state {
        case .loaded(let reminderLists):
            reloadView(with: reminderLists)
        case .select(let index):
            selectReminderList(at: index)
        default:
            return
        }
    }
    
    private func reloadView(with reminderLists: [ReminderList]) {
    
        viewControllerWrapper?.reloadView(with: reminderLists)
        self.reminderLists = reminderLists
    }
    
    private func selectReminderList(at index: Int) {
        
        guard let viewController = viewControllerWrapper?.unwrap() else { return }
        coordinator.showReminderList(reminderLists[index], from: viewController)
    }
}
