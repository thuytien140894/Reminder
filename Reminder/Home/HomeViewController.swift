//
//  HomeViewController.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 10/24/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

protocol ViewControllerNavigable: class {
    func selectItem(at index: Int)
}

class HomeViewController: UIViewController {

    private let presenter: HomePresenterProtocol
    private lazy var reminderListCollectionViewController = PagedHorizontalCollectionViewController()
    
    private struct UIConstants {
        static let collectionViewHeightRatio: CGFloat = 0.65
        static let welcomeLabelBottomInset: CGFloat = 50
    }
    
    init(presenter: HomePresenterProtocol) {
        
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupNavigationBar()
        setupUI()
        
        presenter.loadView()
    }
    
    private func setupNavigationBar() {
        
        title = "TODO"
    }

    private func setupUI() {
        
        setupReminderListCollectionView()
        setupWelcomeLabel()
    }
    
    private func setupReminderListCollectionView() {
        
        addChild(reminderListCollectionViewController)
        view.addSubview(reminderListCollectionViewController.view)
        reminderListCollectionViewController.didMove(toParent: self)
        reminderListCollectionViewController.register(cellClass: ReminderListCell.self, withReuseIdentifier: ReminderListCell.reuseIdentifier)
        setupReminderListCollectionViewConstraints()
    }
    
    private func setupReminderListCollectionViewConstraints() {
        
        guard let collectionView = reminderListCollectionViewController.view else { return }
        let collectionViewConstraints = [
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: UIConstants.collectionViewHeightRatio)
        ]
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
    
    private func setupWelcomeLabel() {
        
        let label = UILabel()
        label.text = "Hello world"
        view.addSubview(label)
        
        let constraints = [
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: reminderListCollectionViewController.view.topAnchor, constant: -UIConstants.welcomeLabelBottomInset)
        ]
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}

extension HomeViewController: ViewControllerProtocol {
    
    func reloadView(with displayData: [ReminderList]) {
        
        reminderListCollectionViewController.reload(with: displayData)
        print(displayData)
    }
}

extension HomeViewController: ViewControllerNavigable {
    
    func selectItem(at index: Int) {
        
        presenter.selectReminderList(at: index)
    }
}
