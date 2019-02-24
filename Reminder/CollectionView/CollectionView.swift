//
//  CollectionView.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/20/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

class CollectionView: UICollectionView {

    var reuseIdentifier = "Cell"
    
    init(frame: CGRect) {
        
        super.init(frame: frame, collectionViewLayout: UICollectionViewLayout())
        setupCollectionViewLayout()
    }
    
    func setupCollectionViewLayout() {
        
        fatalError("Cannot be used directly.")
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
}
