//
//  HomePresenter.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

protocol PresenterProtocol: class {
    func loadView()
}

protocol InteractorDelegateProtocol: class {
    func fetched(reminderLists: [ReminderList])
}

class HomePresenter: PresenterProtocol {
    
    weak var viewController: ViewControllerProtocol?
    var interactor: InteractorProtocol?
    
    func loadView() {
        
        interactor?.fetchReminderLists()
    }
}

extension HomePresenter: InteractorDelegateProtocol {
    
    func fetched(reminderLists: [ReminderList]) {
        
        viewController?.reloadView(with: reminderLists)
    }
}
