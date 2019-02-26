//
//  ReminderListPresenter.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 2/24/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

protocol ReminderListPresenterProtocol: PresenterProtocol {}

class ReminderListPresenter: ReminderListPresenterProtocol {
    
    var viewControllerWrapper: ViewController<Reminder>?
    private let interactor: ReminderListInteractorProtocol
    private let wireframe: WireFrameProtocol
    
    init(interactor: ReminderListInteractorProtocol, wireframe: WireFrameProtocol) {
        
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func loadView() {
        
        interactor.fetchReminders()
    }
}

extension ReminderListPresenter: InteractorDelegateProtocol {
    
    func fetched(displayData: [Reminder]) {
        
        viewControllerWrapper?.reloadView(with: displayData)
    }
}
