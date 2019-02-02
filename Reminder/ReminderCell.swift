//
//  PhotoCell.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/20/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

protocol CollectionViewCellDisplayModel {}

protocol CollectionViewCell {
    func updateDisplay(with displayModel: CollectionViewCellDisplayModel)
}

class ReminderCell: UICollectionViewCell {
    
    static let reuseIdentifier = "photoCell"
    
    private let descriptionView = UIStackView()
    private let title = UILabel()
    
    private struct UIConstants {
        static let descriptionSpacing: CGFloat = 5
        static let cornerRadius: CGFloat = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        
        backgroundColor = .white
        layer.cornerRadius = UIConstants.cornerRadius
        layer.masksToBounds = true
        
        setupDescriptionView()
    }
    
    private func setupDescriptionView() {
        
        descriptionView.addArrangedSubview(title)
        
        let subtitle = UILabel()
        subtitle.text = "Subtitle"
        descriptionView.addArrangedSubview(subtitle)
        
        descriptionView.axis = .vertical
        descriptionView.spacing = UIConstants.descriptionSpacing
        descriptionView.alignment = .center
        descriptionView.backgroundColor = .white
        contentView.addSubview(descriptionView)
        setupDescriptionViewConstraints()
    }
    
    private func setupDescriptionViewConstraints() {
        
        let descriptionViewConstraints = [
            descriptionView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            descriptionView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            descriptionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ]
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(descriptionViewConstraints)
        
        descriptionView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        descriptionView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}

extension ReminderCell: CollectionViewCell {
    
    func updateDisplay(with displayModel: CollectionViewCellDisplayModel) {
        
        guard let reminderList = displayModel as? ReminderList else { return }
        title.text = reminderList.title
    }
}
