//
//  ImagesView.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 21.03.2023.
//

import UIKit

protocol ImageUpdatable: AnyObject {
    func updateUI(with images: [UIImage?])
    func updateSelectedImage(index: Int)
}

final class ImagesView: UIView {

    private let scrollView = UIScrollView()
    private var imagesCollectionView = ThumbnailCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    private var selectedImageIndex = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ImageUpdatable

extension ImagesView: ImageUpdatable {
    
    func updateUI(with images: [UIImage?]) {
        for (index, image) in images.enumerated() {
            let imageView = UIImageView(image: image)
            imageView.contentMode = .scaleAspectFit
            imageView.frame = imageFrame(for: index)
            scrollView.addSubview(imageView)
        }
        imagesCollectionView.updateImages(with: images)
        scrollView.contentSize = scrollContentSize(itemsCount: images.count)
        updateSelectedImage(index: selectedImageIndex)
    }
    
    func updateSelectedImage(index: Int) {
        selectedImageIndex = index
        let offset = CGPoint(x: frame.width * CGFloat(selectedImageIndex), y: 0)
        scrollView.setContentOffset(offset, animated: true)
    }
}

// MARK: - Views settings

extension ImagesView {
        
    private func imageFrame(for index: Int) -> CGRect {
        let x = frame.width * CGFloat(index)
        let y: CGFloat = 0
        let width = frame.width
        let height = frame.height * 4/5
        return CGRect(x: x, y: y, width: width, height: height)
    }
    
    private func scrollContentSize(itemsCount: Int) -> CGSize {
        return CGSize(
            width: frame.width * CGFloat(itemsCount),
            height: frame.height * 4/5
        )
    }
    
    private func setupView() {
        [scrollView, imagesCollectionView].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        scrollView.backgroundColor = .clear
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        
        imagesCollectionView.imagesView = self
        imagesCollectionView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 4/5),
            
            imagesCollectionView.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 10),
            imagesCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imagesCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 70),
            imagesCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -70),
        ])
    }
}

// MARK: - UIScrollViewDelegate

extension ImagesView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.frame.width != 0 else { return }
        let index = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
        if index != selectedImageIndex {
            selectedImageIndex = index
            imagesCollectionView.selectItem(
                at: IndexPath(item: selectedImageIndex, section: 0),
                animated: true,
                scrollPosition: .centeredHorizontally
            )
        }
    }
}
