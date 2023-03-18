//
//  FlashSaleCell.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 15.03.2023.
//

import UIKit

final class FlashSaleCell: UICollectionViewCell {
    
    private let imageItem = UIImageView()
    private let personIcon = UIImageView()
    private let discountLabel = UILabel()
    private let nameLabel = UILabel()
    private let categoryLabel = UILabel()
    private let priceLabel = UILabel()
    private let addButton = UIButton()
    private let favoriteButton = UIButton()
    
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
        
        discountLabel.layer.cornerRadius = discountLabel.frame.height / 2
        categoryLabel.layer.cornerRadius = categoryLabel.frame.height / 2
        addButton.layer.cornerRadius = addButton.frame.height / 2
        favoriteButton.layer.cornerRadius = favoriteButton.frame.height / 2
    }
    
    func setup(with viewModel: ShopItemCellViewModel) {
        categoryLabel.text = viewModel.category
        nameLabel.text = viewModel.name
        priceLabel.text = viewModel.price
        imageItem.image = viewModel.image
        discountLabel.text = viewModel.discount
    }
    
    private func setupViews() {
        backgroundColor = Resources.Colors.background
        layer.cornerRadius = 10
        clipsToBounds = true
        
        addSubview(imageItem)
        imageItem.contentMode = .scaleAspectFill

        personIcon.image = Resources.Images.flashSalePersonIcon
        
        discountLabel.font = UIFont.semiBold(with: 10)
        discountLabel.backgroundColor = Resources.Colors.discountBackground
        discountLabel.textColor = Resources.Colors.white
        discountLabel.textAlignment = .center
        discountLabel.clipsToBounds = true
        
        categoryLabel.font = UIFont.semiBold(with: 10)
        categoryLabel.backgroundColor = Resources.Colors.categoryLabelBackground
        categoryLabel.textColor = Resources.Colors.title
        categoryLabel.textAlignment = .center
        categoryLabel.clipsToBounds = true
        
        nameLabel.font = UIFont.bold(with: 12)
        nameLabel.textColor = Resources.Colors.black
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 2
        
        priceLabel.font = UIFont.bold(with: 10)
        priceLabel.textColor = Resources.Colors.black
        
        favoriteButton.setImage(Resources.Images.favorites, for: .normal)
        favoriteButton.backgroundColor = Resources.Colors.addButtonBackground
        favoriteButton.tintColor = Resources.Colors.accentColor
        favoriteButton.makeSystemAnimation()
        
        addButton.setImage(Resources.Images.addImageBig, for: .normal)
        addButton.backgroundColor = Resources.Colors.addButtonBackground
        addButton.tintColor = Resources.Colors.accentColor
        addButton.makeSystemAnimation()
        
        [personIcon, discountLabel, categoryLabel, nameLabel, priceLabel, favoriteButton, addButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupConstraints() {
        imageItem.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageItem.topAnchor.constraint(equalTo: topAnchor),
            imageItem.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageItem.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageItem.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            personIcon.topAnchor.constraint(equalTo: topAnchor, constant: 7.5),
            personIcon.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7.5),
            personIcon.widthAnchor.constraint(equalToConstant: 24),
            personIcon.heightAnchor.constraint(equalToConstant: 24),
            
            discountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            discountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            discountLabel.widthAnchor.constraint(equalToConstant: 50),
            discountLabel.heightAnchor.constraint(equalToConstant: 18),
            
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            categoryLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -57),
            categoryLabel.widthAnchor.constraint(equalToConstant: 50),
            categoryLabel.heightAnchor.constraint(equalToConstant: 17),
            
            nameLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: priceLabel.topAnchor, constant: -5),
            
            priceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            priceLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            favoriteButton.widthAnchor.constraint(equalToConstant: 28),
            favoriteButton.heightAnchor.constraint(equalToConstant: 28),
            favoriteButton.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -5),
            favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            addButton.widthAnchor.constraint(equalToConstant: 35),
            addButton.heightAnchor.constraint(equalToConstant: 35),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            addButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7)
            
        ])
    }
}
