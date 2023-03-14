//
//  LocationButton.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 14.03.2023.
//

import UIKit

final class LocationButton: UIButton {
    
    private let title = UILabel()
    private let icon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAppearance()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupAppearance() {
        backgroundColor = Resources.Colors.background
        
        title.text = "Location"
        title.textColor = Resources.Colors.title
        title.font = UIFont.regular(with: 12)
        
        icon.image = Resources.Images.downIcon
        icon.image?.withTintColor(Resources.Colors.title)
        icon.contentMode = .scaleAspectFit
    }
    
    private func setupViews() {
        makeSystemAnimation()
        
        [title, icon].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            icon.leadingAnchor.constraint(equalTo: title.trailingAnchor, constant: 5),
            icon.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
