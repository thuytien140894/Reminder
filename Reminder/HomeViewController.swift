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

class HomeViewController: UIViewController {

    public var presenter: PresenterProtocol
    
    // MARK: - UI Properties
    
    private lazy var collectionView = {
        return HorizontalCollectionView(frame: view.bounds)
    }()
    
    init(presenter: PresenterProtocol) {
        
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
        
        setupCollectionView()
        setupLabel()
    }
    
    private func setupCollectionView() {
        
        collectionView.backgroundColor = .red
        collectionView.setCellHeight(ratioToWidth: 1.25)
        collectionView.reuseIdentifier = ReminderCell.reuseIdentifier
        
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
    }
    
    private func setupCollectionViewConstraints() {
        
        let collectionViewConstraints = [
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ]
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
    
    private func setupLabel() {
        
        let label = UILabel()
        label.text = "Hello world"
        view.addSubview(label)
        
        let constraints = [
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -50)
        ]
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints)
    }
}

extension HomeViewController: ViewControllerProtocol {
    
    func reloadView(with displayData: [ReminderList]) {
        
        print(displayData)
    }
}

typealias HomeDelegate  = HomeViewController
extension HomeDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(ReminderDetailViewController(), animated: true)
    }
}
