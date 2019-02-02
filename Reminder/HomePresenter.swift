//
//  HomePresenter.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

protocol PresenterProtocol: class {
    var viewController: ViewControllerProtocol? { get }
    func loadView()
    func selectReminderList(at index: Int)
}

protocol InteractorDelegateProtocol: class {
    func fetched(reminderLists: [ReminderList])
}

class HomePresenter: PresenterProtocol {
    
    weak var viewController: ViewControllerProtocol?
    var interactor: InteractorProtocol
    var wireframe: WireFrameProtocol
    private var reminderListTitles: [String] = []
    
    init(interactor: InteractorProtocol, wireframe: WireFrameProtocol) {
        
        self.interactor = interactor
        self.wireframe = wireframe 
    }
    
    func loadView() {
        
        interactor.fetchReminderLists()
    }
    
    func selectReminderList(at index: Int) {
        
        wireframe.showReminderDetailPage(withTitle: reminderListTitles[index])
    }
}

extension HomePresenter: InteractorDelegateProtocol {
    
    func fetched(reminderLists: [ReminderList]) {
        
        reminderListTitles = reminderLists.map { $0.title }
        viewController?.reloadView(with: reminderLists)
    }
}
