//
//  VerticalCollectionViewController.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/20/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

class VerticalCollectionViewController: CollectionViewController {
    
    override func setupCollectionView() {
        
        collectionLayout = CollectionDynamicLayout()
        
        guard let collectionDynamicLayout = collectionLayout as? CollectionDynamicLayout else { return }
        collectionDynamicLayout.delegate = self
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionDynamicLayout)
        
        super.setupCollectionView()
    }
}

extension VerticalCollectionViewController: DynamicallySizedCellLayoutDelegate {
    
    func collectionView(heightAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        guard let image = UIImage(named: "Eiffel") else { return 0 }
        return image.size.height
    }
}
