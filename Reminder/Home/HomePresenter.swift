//
//  HomePresenter.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

protocol HomePresenterProtocol: PresenterProtocol {
    func selectReminderList(at index: Int)
}

class HomePresenter: HomePresenterProtocol {
    
    var viewControllerWrapper: ViewController<ReminderList>?
    private let interactor: HomeInteractorProtocol
    private let wireframe: HomeWireFrameProtocol
    private var reminderLists: [ReminderList] = []
    
    init(interactor: HomeInteractorProtocol, wireframe: HomeWireFrameProtocol) {
        
        self.interactor = interactor
        self.wireframe = wireframe 
    }
    
    func loadView() {
        
        interactor.fetchReminderLists()
    }
    
    func selectReminderList(at index: Int) {
        
        interactor.setCurrentReminderList(reminderLists[index])
        
        guard let viewController = viewControllerWrapper?.unwrap() else { return }
        wireframe.showReminderDetailPage(from: viewController)
    }
}

extension HomePresenter: InteractorDelegateProtocol {
    
    func fetched(displayData: [ReminderList]) {
        
        reminderLists = displayData
        viewControllerWrapper?.reloadView(with: displayData)
    }
}
