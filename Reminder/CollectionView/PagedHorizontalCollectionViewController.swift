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
    private var newCellIndex = 0
    private var numberOfCells: Int {
        return displayModels.count
    }
    private var displayModels: [ReminderList] = [] {
        didSet {
            dataSource?.displayModels = displayModels
            pageControl.numberOfPages = numberOfCells
        }
    }
    private var dataSource: CollectionViewDataSource<ReminderList>?
    
    weak var viewRenderer: ViewRenderable?
    
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
        
        super.viewDidLoad()
        
        setupCollectionView()
        setupPageControl()
    }

    private func setupCollectionView() {
        
        collectionView.backgroundColor = .red
        collectionView.setCellHeight(ratioToWidth: UIConstants.cellHeightRatio)
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
        dataSource = CollectionViewDataSource(displayModels: displayModels, reuseIdentifier: reuseIdentifier)
        collectionView.dataSource = dataSource
    }
    
    func reload(with displayModels: [ReminderList]) {
        
        self.displayModels = displayModels
        collectionView.reloadData()
    }
}

extension PagedHorizontalCollectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        viewRenderer?.state = .select(indexPath.item)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // Stop scrollview from sliding
        targetContentOffset.pointee = scrollView.contentOffset
        
        guard !handleSwipeGestureIfNecessary(forVelocity: velocity) else { return }
        newCellIndex = getIndexOfMainCellOnScreen()
        scrollToTheNewCell()
    }
    
    private func handleSwipeGestureIfNecessary(forVelocity velocity: CGPoint) -> Bool {
        
        let swipeVelocityLimit: CGFloat = 0.5
        let didSwipeLeft = velocity.x > swipeVelocityLimit
        let didSwipeRight = velocity.x < -swipeVelocityLimit
        let didSwipe = didSwipeLeft || didSwipeRight
        
        guard didSwipe else { return false }
        
        newCellIndex = didSwipeLeft ?
            min(numberOfCells - 1, newCellIndex + 1) :
            max(0, newCellIndex - 1)
        
        scrollToTheNewCell()
        
        return true
    }
    
    private func scrollToTheNewCell() {
        
        let indexPath = IndexPath(item: newCellIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        pageControl.currentPage = newCellIndex
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
