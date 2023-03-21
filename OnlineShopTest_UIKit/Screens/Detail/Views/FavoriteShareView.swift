//
//  FavoriteShareView.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 21.03.2023.
//

import UIKit

final class FavoriteShareView: UIView {
    
    private let stackView = UIStackView()
    
    private let favoriteButton = UIButton()
    private let shareButton = UIButton()
    private let separatorView = UIImageView(image: Resources.Images.separator)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = Resources.Colors.addButtonBackground
        layer.cornerRadius = 10
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        [favoriteButton, separatorView, shareButton].forEach { stackView.addArrangedSubview($0) }
        
        favoriteButton.setImage(Resources.Images.favorites, for: .normal)
        favoriteButton.makeSystemAnimation()
        separatorView.contentMode = .center
        shareButton.setImage(Resources.Images.share, for: .normal)
        shareButton.makeSystemAnimation()
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
