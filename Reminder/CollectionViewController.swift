//
//  CollectionViewController.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/20/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

enum CollectionViewLayout {
    case vertical
    case horizontal
}

class CollectionViewController: UIViewController {

    private let reuseIdentifier = "Cell"
    let numberOfCells = 10
    var collectionView: UICollectionView?
    var collectionLayout: UICollectionViewLayout?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        setupCollectionView()
    }
    
    func setupCollectionView() {
        
        collectionView?.backgroundColor = .white
        collectionView?.register(ReminderCell.self, forCellWithReuseIdentifier: ReminderCell.reuseIdentifier)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
}

extension CollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numberOfCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReminderCell.reuseIdentifier, for: indexPath)

        return cell
    }
}

extension CollectionViewController: UICollectionViewDelegate {
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    
     func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        return true
     }
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        navigationController?.pushViewController(ReminderDetailViewController(), animated: true)
    }
}
