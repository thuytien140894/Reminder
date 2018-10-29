//
//  PhotoCell.swift
//  Starter
//
//  Created by Tien Thuy Ho on 10/20/18.
//  Copyright © 2018 Tien Thuy Ho. All rights reserved.
//

import UIKit

class ReminderCell: UICollectionViewCell {
    
    static let reuseIdentifier = "photoCell"
    
    private let imageView = UIImageView()
    private let descriptionView = UIStackView()
    
    private struct UIConstants {
        static let descriptionSpacing: CGFloat = 5
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    private func setupUI() {
        
        backgroundColor = .blue
        setupImageView()
        setupDescriptionView()
    }
    
    private func setupImageView() {
        
        imageView.image = UIImage(named: "Eiffel")
        contentView.addSubview(imageView)
        setupImageViewConstraints()
    }
    
    private func setupImageViewConstraints() {
        
        let imageViewConstraints = [
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ]
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(imageViewConstraints)
    }
    
    private func setupDescriptionView() {
        
        let title = UILabel()
        title.text = "Title"
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
