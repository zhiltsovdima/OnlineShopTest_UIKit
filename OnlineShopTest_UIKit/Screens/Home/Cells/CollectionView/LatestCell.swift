//
//  LatestCell.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 15.03.2023.
//

import UIKit

final class LatestCell: UICollectionViewCell {
    
    private let imageItem = UIImageView()
    private let nameLabel = UILabel()
    private let categoryLabel = UILabel()
    private let priceLabel = UILabel()
    private let addButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        addButton.layer.cornerRadius = addButton.frame.height / 2
    }
    
    func setup(with viewModel: ShopItemCellViewModel) {
        categoryLabel.text = viewModel.category
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        imageItem.image = viewModel.image
    }

    private func setupViews() {
        backgroundColor = Resources.Colors.background
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageItem)
        imageItem.contentMode = .scaleAspectFill
        
        categoryLabel.font = UIFont.semiBold(with: 8)
        categoryLabel.backgroundColor = Resources.Colors.categoryLabelBackground
        categoryLabel.textColor = Resources.Colors.title
        categoryLabel.textAlignment = .center
        categoryLabel.clipsToBounds = true
        categoryLabel.layer.cornerRadius = 4
        
        nameLabel.font = UIFont.bold(with: 10)
        nameLabel.textColor = Resources.Colors.black
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 2
        nameLabel.sizeToFit()
        
        priceLabel.font = UIFont.bold(with: 9)
        priceLabel.textColor = Resources.Colors.black
        
        addButton.setImage(Resources.Images.addImage, for: .normal)
        addButton.imageView?.contentMode = .scaleAspectFit
        addButton.backgroundColor = Resources.Colors.addButtonBackground
        addButton.tintColor = Resources.Colors.accentColor
        addButton.makeSystemAnimation()
        
        [categoryLabel, nameLabel, priceLabel, addButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupConstraints() {
        imageItem.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageItem.topAnchor.constraint(equalTo: topAnchor),
            imageItem.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageItem.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            categoryLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -32),
            categoryLabel.widthAnchor.constraint(equalToConstant: 40),
            categoryLabel.heightAnchor.constraint(equalToConstant: 12),
            
            nameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            nameLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor),
            
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7),
            
            addButton.widthAnchor.constraint(equalToConstant: 20),
            addButton.heightAnchor.constraint(equalToConstant: 20),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)

        ])
    }
}
