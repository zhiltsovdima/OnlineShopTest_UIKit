//
//  HeaderView.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 16.03.2023.
//

import UIKit

final class HeaderView: UITableViewHeaderFooterView {
    
    private let nameLabel = UILabel()
    private let viewAllButton = UIButton()
    
    func setup(with name: String) {
        nameLabel.text = name
        
        addSubview(nameLabel)
        contentView.addSubview(viewAllButton)
        
        nameLabel.font = UIFont.semiBold(with: 16)
        nameLabel.textColor = Resources.Colors.title
        
        viewAllButton.setTitle("View all", for: .normal)
        viewAllButton.titleLabel?.font = UIFont.regular(with: 12)
        viewAllButton.setTitleColor(Resources.Colors.subTitle, for: .normal)
        viewAllButton.makeSystemAnimation()
        
        [nameLabel, viewAllButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: HomeViewModel.Constants.latestItemsInsetSpacing),
            
            viewAllButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            viewAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -(HomeViewModel.Constants.latestItemsInsetSpacing))
        ])
    }
}
