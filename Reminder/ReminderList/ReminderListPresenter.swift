//
//  ReminderListPresenter.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 2/24/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

protocol ReminderListPresenterProtocol: PresenterProtocol {
    func goBackToHome()
}

class ReminderListPresenter: ReminderListPresenterProtocol {
    
    var viewControllerWrapper: ViewController<Reminder>?
    private let interactor: ReminderListInteractorProtocol
    private let wireframe: ReminderListWireFrameProtocol
    
    init(interactor: ReminderListInteractorProtocol, wireframe: ReminderListWireFrameProtocol) {
        
        self.interactor = interactor
        self.wireframe = wireframe
    }
    
    func loadView() {
        
        interactor.fetchReminders()
    }
    
    func goBackToHome() {
        
        guard let viewController = viewControllerWrapper?.unwrap() else { return }
        wireframe.goBackToHome(from: viewController)
    }
}

extension ReminderListPresenter: InteractorDelegateProtocol {
    
    func fetched(displayData: [Reminder]) {
        
        viewControllerWrapper?.reloadView(with: displayData)
    }
}
