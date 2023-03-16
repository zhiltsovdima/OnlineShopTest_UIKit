//
//  ProfileImage.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 14.03.2023.
//

import UIKit

final class ProfileImage: UIImageView {
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.height / 2
    }
    
    private func setupView() {
        contentMode = .scaleAspectFill
        layer.borderWidth = 1
        layer.borderColor = Resources.Colors.subTitle.cgColor
        clipsToBounds = true
    }
}
