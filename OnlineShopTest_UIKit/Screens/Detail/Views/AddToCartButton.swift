//
//  AddToCartButton.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 19.03.2023.
//

import UIKit

final class AddToCartButton: UIButton {
    
    private let stackView = UIStackView()
    let priceLabel = UILabel()
    private let textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = Resources.Colors.accentColor
        layer.cornerRadius = 15
        makeSystemAnimation()
        
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        [priceLabel, textLabel].forEach { stackView.addArrangedSubview($0) }
        
        priceLabel.font = UIFont.regular(with: 8)
        priceLabel.textColor = Resources.Colors.priceOnButton
        priceLabel.textAlignment = .center
        
        textLabel.text = "ADD TO CART"
        textLabel.font = UIFont.bold(with: 9)
        textLabel.textColor = Resources.Colors.buttonTitle
        textLabel.textAlignment = .center
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
