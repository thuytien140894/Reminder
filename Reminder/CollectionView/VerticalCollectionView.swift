//
//  VerticalCollectionView.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/20/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

class VerticalCollectionView: CollectionView {
    
    override func setupCollectionViewLayout() {
        
        collectionViewLayout = CollectionDynamicLayout()
        
        guard let collectionDynamicLayout = collectionViewLayout as? CollectionDynamicLayout else { return }
        collectionDynamicLayout.delegate = self
    }
}

extension VerticalCollectionView: DynamicallySizedCellLayoutDelegate {
    
    func collectionView(heightAtIndexPath indexPath: IndexPath) -> CGFloat {
        
        guard let image = UIImage(named: "Eiffel") else { return 0 }
        return image.size.height
    }
}
