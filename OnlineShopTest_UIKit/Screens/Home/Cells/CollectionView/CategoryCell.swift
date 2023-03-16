//
//  CategoryCell.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 15.03.2023.
//

import UIKit

final class CategoryCell: UICollectionViewCell {
    
    private let icon = UIImageView()
    private let categoryName = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with category: (String, UIImage?)) {
        categoryName.text = category.0
        icon.image = category.1
    }
    
    private func setupViews() {
        backgroundColor = Resources.Colors.background

        [categoryName, icon].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        categoryName.font = UIFont.regular(with: 9)
        categoryName.numberOfLines = 0
        categoryName.textAlignment = .center
        categoryName.textColor = Resources.Colors.subTitle
        icon.contentMode = .scaleAspectFit
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            icon.centerXAnchor.constraint(equalTo: centerXAnchor),
            icon.topAnchor.constraint(equalTo: topAnchor),
            
            categoryName.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 10),
            categoryName.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            categoryName.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryName.widthAnchor.constraint(equalTo: widthAnchor)
        ])
    }
    
    
}
