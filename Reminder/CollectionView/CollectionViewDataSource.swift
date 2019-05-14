//
//  CollectionViewDataSource.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 5/16/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import UIKit

class CollectionViewDataSource<Model: CollectionViewCellDisplayable>: NSObject, UICollectionViewDataSource {
    
    var displayModels: [Model] = []
    private let reuseIdentifier: String
    
    init(displayModels: [Model], reuseIdentifier: String) {
        
        self.displayModels = displayModels
        self.reuseIdentifier = reuseIdentifier
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return displayModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        guard
            let collectionCell = cell as? CollectionViewCell,
            Utils.isNotOutOfBounds(index: indexPath.item, arrayCount: displayModels.count) else { return cell }
        
        collectionCell.updateDisplay(with: displayModels[indexPath.item])
        
        return cell
    }
}
