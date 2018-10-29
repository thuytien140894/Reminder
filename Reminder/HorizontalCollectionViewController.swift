//
//  HorizontalCollectionViewController.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/20/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

class HorizontalCollectionViewController: CollectionViewController {
    
    private let pageControl = UIPageControl()
    private var indexOfMainCellOnScreen: Int = 0
    
    private struct UIConstants {
        static let lineSpacing: CGFloat = 20
        static let collectionViewInset: CGFloat = 40
        static let cellHeight: CGFloat = 600
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupPageControl()
    }
    
    override func setupCollectionView() {
        
        collectionLayout = UICollectionViewFlowLayout()
        
        guard let collectionFlowLayout = collectionLayout as? UICollectionViewFlowLayout else { return }
        collectionFlowLayout.scrollDirection = .horizontal
        let cellWidth = view.frame.width - 2 * UIConstants.collectionViewInset
        collectionFlowLayout.itemSize = CGSize(width: cellWidth, height: UIConstants.cellHeight)
        collectionFlowLayout.minimumLineSpacing = 20
        collectionFlowLayout.sectionInset = UIEdgeInsets(top: 0, left: UIConstants.collectionViewInset, bottom: 0, right: UIConstants.collectionViewInset)
        
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: collectionFlowLayout)
        
        super.setupCollectionView()
    }
    
    private func setupPageControl() {
        
        pageControl.numberOfPages = numberOfCells
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .black
        pageControl.currentPageIndicatorTintColor = .gray
        view.addSubview(pageControl)
        view.bringSubviewToFront(pageControl)
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        let pageControlConstraints = [
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40)
        ]
        NSLayoutConstraint.activate(pageControlConstraints)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        targetContentOffset.pointee = scrollView.contentOffset
        indexOfMainCellOnScreen = getIndexOfMainCellOnScreen()
        let indexPath = IndexPath(item: indexOfMainCellOnScreen, section: 0)
        collectionLayout?.collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        pageControl.currentPage = indexOfMainCellOnScreen
    }
    
    private func getIndexOfMainCellOnScreen() -> Int {
        
        guard let collectionFlowLayout = collectionLayout as? UICollectionViewFlowLayout else { return 0 }
        let cellWidth = collectionFlowLayout.itemSize.width + UIConstants.lineSpacing
        
        guard let contentOffset = collectionLayout?.collectionView?.contentOffset.x else { return 0 }
        let contentOffsetExcludingLeftInset = contentOffset - UIConstants.collectionViewInset
        
        let cellOffset = Int(round(contentOffsetExcludingLeftInset / cellWidth))
        let index = min(numberOfCells - 1, cellOffset)
        
        return index
    }
}
