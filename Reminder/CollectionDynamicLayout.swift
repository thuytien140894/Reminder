//
//  CollectionDynamicLayout.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/20/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//
//  Tutorial: https://www.raywenderlich.com/392-uicollectionview-custom-layout-tutorial-pinterest
//

import UIKit

protocol DynamicallySizedCellLayoutDelegate: class {
    func collectionView(heightAtIndexPath indexPath: IndexPath) -> CGFloat
}

class CollectionDynamicLayout: UICollectionViewLayout {

    weak var delegate: DynamicallySizedCellLayoutDelegate?
    private let numberOfColumns = 1
    private let cellPadding: CGFloat = 6
    private var layoutAttributes = [UICollectionViewLayoutAttributes]()
    private var columnWidth: CGFloat  {
        return contentWidth / CGFloat(numberOfColumns)
    }
    
    private var contentHeight: CGFloat = 0
    private var contentWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        let insets = collectionView.contentInset
        return collectionView.frame.width - (insets.left + insets.right)
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }
    
    override func prepare() {
        
        guard layoutAttributes.isEmpty,
            let collectionView = collectionView,
            let delegate = delegate else { return }
        
        let columns = 0..<numberOfColumns
        let xOffsets = columns.map { CGFloat($0) * columnWidth }
        var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)
        let section = 0
        
        for index in 0..<collectionView.numberOfItems(inSection: section) {
            let indexPath = IndexPath(item: index, section: section)
            let column = index % numberOfColumns
            let height = delegate.collectionView(heightAtIndexPath: indexPath)
            let cellHeight = height + 2 * cellPadding
            
            let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: cellHeight)
            let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
            
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            layoutAttributes.append(attributes)
            
            contentHeight = max(contentHeight, frame.maxY)
            yOffsets[column] = insetFrame.maxY
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        let visibleLayoutAttributes = layoutAttributes.filter { attribute in
            return attribute.frame.intersects(rect)
        }
        
        return visibleLayoutAttributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        
        return layoutAttributes[indexPath.item]
    }
}
