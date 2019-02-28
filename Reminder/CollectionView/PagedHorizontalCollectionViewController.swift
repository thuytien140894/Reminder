//
//  PagedHorizontalCollectionView.swift
//  Reminder
//
//  Created by Tien Thuy Ho on 2/2/19.
//  Copyright © 2019 Tien Thuy Ho. All rights reserved.
//

import UIKit

class PagedHorizontalCollectionViewController: UIViewController {
    
    private lazy var collectionView = {
        HorizontalCollectionView(frame: view.bounds)
    }()
    private let pageControl = UIPageControl()
    private var indexOfMainCellOnScreen = 0
    private var numberOfCells: Int {
        return displayModels.count
    }
    private var displayModels: [CollectionViewCellDisplayable] = []
    
    private struct UIConstants {
        static let cellHeightRatio: CGFloat = 1.25
        static let pageControlBottomInset: CGFloat = 40
        static let collectionViewLineSpacing: CGFloat = 20
        static let collectionViewInset: CGFloat = 40
    }
    
    init() {
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
        setupCollectionView()
        setupPageControl()
    }

    private func setupCollectionView() {
        
        collectionView.backgroundColor = .red
        collectionView.setCellHeight(ratioToWidth: UIConstants.cellHeightRatio)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        setupCollectionViewConstraints()
    }
    
    private func setupCollectionViewConstraints() {
        
        let collectionViewConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
    
    private func setupPageControl() {
        
        pageControl.accessibilityIdentifier = "pageControl"
        pageControl.numberOfPages = 0
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = .black
        pageControl.currentPageIndicatorTintColor = .gray
        view.addSubview(pageControl)
        setupPageControlConstraints()
    }
    
    private func setupPageControlConstraints() {
        
        let pageControlConstraints = [
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -UIConstants.pageControlBottomInset)
        ]
        
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(pageControlConstraints)
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    func register(cellClass: AnyClass?, withReuseIdentifier
        reuseIdentifier: String) {
        
        collectionView.register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.reuseIdentifier = reuseIdentifier
    }
    
    func reload(with displayModels: [ReminderList]) {
        
        self.displayModels = displayModels
        pageControl.numberOfPages = numberOfCells
        collectionView.reloadData()
    }
}

extension PagedHorizontalCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.collectionView.reuseIdentifier, for: indexPath)
        guard
            let reminderCell = cell as? CollectionViewCell,
            Utils.isNotOutOfBounds(index: indexPath.item, arrayCount: displayModels.count) else { return cell }
        
        reminderCell.updateDisplay(with: displayModels[indexPath.item])
        
        return cell
    }
}

extension PagedHorizontalCollectionViewController: UICollectionViewDelegate {
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let parentViewController = parent as? ViewControllerNavigable else { return }
        parentViewController.selectItem(at: indexPath.item)
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
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        targetContentOffset.pointee = scrollView.contentOffset
        indexOfMainCellOnScreen = getIndexOfMainCellOnScreen()
        let indexPath = IndexPath(item: indexOfMainCellOnScreen, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        pageControl.currentPage = indexOfMainCellOnScreen
    }
    
    private func getIndexOfMainCellOnScreen() -> Int {
        
        guard let collectionFlowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return 0 }
        let cellWidth = collectionFlowLayout.itemSize.width + collectionFlowLayout.minimumLineSpacing
        
        let contentOffset = collectionView.contentOffset.x
        let contentLeftInset = collectionFlowLayout.sectionInset.left
        let contentOffsetExcludingLeftInset = contentOffset - contentLeftInset

        let cellOffset = Int(round(contentOffsetExcludingLeftInset / cellWidth))
        let index = min(numberOfCells - 1, cellOffset)
        
        return index
    }
}
