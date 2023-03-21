//
//  ImagesView.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 21.03.2023.
//

import UIKit

final class ImagesView: UIView {
        
    private let scrollView = UIScrollView()
    private let imagesStackView = UIStackView()
    
    private var images = [UIImage?]()
    private var selectedImageIndex = 0
    
    private var scrollContentSize: CGSize {
        return CGSize(
            width: frame.width * CGFloat(images.count),
            height: frame.height * 4/5)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func imageButtonTapped(sender: UIButton) {
        updateSelectedImage(index: sender.tag)
    }
    
    func updateUI(with images: [UIImage?]) {
        self.images = images
        for (index, image) in images.enumerated() {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = imageFrame(for: index)
            scrollView.addSubview(imageView)
            
            let imageButton = createImageButton(for: index)
            imagesStackView.addArrangedSubview(imageButton)
        }
        scrollView.contentSize = scrollContentSize
        updateSelectedImage(index: selectedImageIndex)
    }
        
    private func imageFrame(for index: Int) -> CGRect {
        let x = frame.width * CGFloat(index)
        let y: CGFloat = 0
        let width = frame.width
        let height = frame.height * 4/5
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func createImageButton(for index: Int) -> UIButton {
        let imageButton = UIButton()
        imageButton.tag = index
        imageButton.setImage(images[index], for: .normal)
        imageButton.addTarget(self, action: #selector(imageButtonTapped), for: .touchUpInside)
        imageButton.layer.cornerRadius = 10
        imageButton.clipsToBounds = true
        imageButton.imageView?.contentMode = .scaleAspectFill
        imageButton.translatesAutoresizingMaskIntoConstraints = false
        imageButton.widthAnchor.constraint(equalToConstant: 65).isActive = true
        imageButton.heightAnchor.constraint(equalToConstant: 37).isActive = true
        return imageButton
    }
    
    private func updateSelectedImage(index: Int) {
        selectedImageIndex = index
        
        for (buttonIndex, button) in imagesStackView.arrangedSubviews.enumerated() {
            guard let imageButton = button as? UIButton else { continue }
            
            if buttonIndex == selectedImageIndex {
                imageButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            } else {
                imageButton.transform = CGAffineTransform.identity
            }
        }
        
        let offset = CGPoint(x: frame.width * CGFloat(selectedImageIndex), y: 0)
        scrollView.setContentOffset(offset, animated: true)
    }
    
    private func setupView() {
        [scrollView, imagesStackView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        
        imagesStackView.distribution = .fillEqually
        imagesStackView.spacing = 10
        imagesStackView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 4/5),
            
            imagesStackView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 20),
            imagesStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imagesStackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
