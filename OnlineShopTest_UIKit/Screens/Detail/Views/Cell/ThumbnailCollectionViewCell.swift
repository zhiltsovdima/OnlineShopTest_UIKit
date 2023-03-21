//
//  ThumbnailCollectionViewCell.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 21.03.2023.
//

import UIKit

final class ThumbnailCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                imageView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            } else {
                imageView.transform = CGAffineTransform.identity
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = .clear
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 65),
            imageView.heightAnchor.constraint(equalToConstant: 37)
        ])
    }
}
