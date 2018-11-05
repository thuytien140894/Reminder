//
//  HorizontalCollectionView.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/20/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

class HorizontalCollectionView: CollectionView {
    
    private let pageControl = UIPageControl()
    private var indexOfMainCellOnScreen = 0
    
    private struct UIConstants {
        static let lineSpacing: CGFloat = 20
        static let collectionViewInset: CGFloat = 40
        static let cellHeight: CGFloat = 600
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupPageControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPageControl() {
        
        pageControl.numberOfPages = numberOfCells
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .black
        pageControl.currentPageIndicatorTintColor = .gray
        addSubview(pageControl)
        setupPageControlConstraints()
    }
    
    private func setupPageControlConstraints() {
        
        let pageControlConstraints = [
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.topAnchor.constraint(equalTo: topAnchor, constant: 500)
        ]
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(pageControlConstraints)
    }
    
    override func setupCollectionViewLayout() {
        
        collectionViewLayout = UICollectionViewFlowLayout()
        
        guard let collectionFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        collectionFlowLayout.scrollDirection = .horizontal
        let cellWidth = frame.width - 2 * UIConstants.collectionViewInset
        collectionFlowLayout.itemSize = CGSize(width: cellWidth, height: UIConstants.cellHeight)
        collectionFlowLayout.minimumLineSpacing = UIConstants.lineSpacing
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: UIConstants.collectionViewInset, bottom: 0, right: UIConstants.collectionViewInset)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        targetContentOffset.pointee = scrollView.contentOffset
        indexOfMainCellOnScreen = getIndexOfMainCellOnScreen()
        let indexPath = IndexPath(item: indexOfMainCellOnScreen, section: 0)
        scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        pageControl.currentPage = indexOfMainCellOnScreen
    }
    
    private func getIndexOfMainCellOnScreen() -> Int {
        
        guard let collectionFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return 0 }
        let cellWidth = collectionFlowLayout.itemSize.width + UIConstants.lineSpacing
        
        let contentOffset = self.contentOffset.x
        let contentOffsetExcludingLeftInset = contentOffset - UIConstants.collectionViewInset
        
        let cellOffset = Int(round(contentOffsetExcludingLeftInset / cellWidth))
        let index = min(numberOfCells - 1, cellOffset)
        
        return index
    }
    
    internal func setCellHeight(ratioToWidth ratio: CGFloat) {
        
        guard let collectionFlowLayout = collectionViewLayout as? UICollectionViewFlowLayout else { return }
        let cellWidth = collectionFlowLayout.itemSize.width
        collectionFlowLayout.itemSize.height = cellWidth * ratio
    }
}
