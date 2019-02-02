//
//  HorizontalCollectionView.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/20/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

class HorizontalCollectionView: CollectionView {
    
    private struct UIConstants {
        static let lineSpacing: CGFloat = 20
        static let collectionViewInset: CGFloat = 40
    }
    
    override func setupCollectionViewLayout() {
        
        collectionViewLayout = UICollectionViewFlowLayout()
        guard let collectionFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        
        collectionFlowLayout.scrollDirection = .horizontal
        let cellWidth = frame.width - 2 * UIConstants.collectionViewInset
        collectionFlowLayout.itemSize = CGSize(width: cellWidth, height: 0)
        collectionFlowLayout.minimumLineSpacing = UIConstants.lineSpacing
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: UIConstants.collectionViewInset, bottom: 0, right: UIConstants.collectionViewInset)
    }
    
    func setCellHeight(ratioToWidth ratio: CGFloat) {
        
        guard let collectionFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let cellWidth = collectionFlowLayout.itemSize.width
        collectionFlowLayout.itemSize.height = cellWidth * ratio
    }
}
