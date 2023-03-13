//
//  UploadItemButton.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 13.03.2023.
//

import UIKit

final class UploadItemButton: UIButton {
    
    let uploadLabel = UILabel()
    let uploadImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAppearance()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height / 2
    }
    
    private func setupAppearance() {
        backgroundColor = Resources.Colors.accentColor
        uploadLabel.text = "Upload Item"
        uploadLabel.textColor = Resources.Colors.buttonTitle
        uploadLabel.font = UIFont.bold(with: 16)
        
        uploadImage.image = Resources.Images.uploadItem
        uploadImage.image?.withTintColor(Resources.Colors.buttonTitle)
        uploadImage.contentMode = .scaleAspectFit
    }
    
    private func setupConstraints() {
        [uploadLabel, uploadImage].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            uploadLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            uploadLabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            uploadImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            uploadImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            uploadImage.trailingAnchor.constraint(equalTo: uploadLabel.leadingAnchor, constant: -5)
        ])
    }
}
