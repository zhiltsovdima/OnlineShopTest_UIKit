//
//  ThumbnailCollectionView.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 21.03.2023.
//

import UIKit

final class ThumbnailCollectionView: UICollectionView {

    private var images: [UIImage?] = []
    private var selectedImageIndex = 0
    
    private let thumbnailSpacing: CGFloat = 30
    
    weak var imagesView: ImageUpdatable?

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateImages(with images: [UIImage?]) {
        self.images = images
        reloadData()
        selectItem(at: IndexPath(item: selectedImageIndex, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    private func setupView() {
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        contentInset = UIEdgeInsets(
            top: 0,
            left: thumbnailSpacing / 2,
            bottom: 0,
            right: thumbnailSpacing / 2
        )
        delegate = self
        dataSource = self
        register(ThumbnailCollectionViewCell.self, forCellWithReuseIdentifier: Resources.CellIdentifier.thumbnailCell)
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = thumbnailSpacing
        flowLayout.minimumInteritemSpacing = thumbnailSpacing
        collectionViewLayout = flowLayout
    }
}

// MARK: - UICollectionViewDataSource

extension ThumbnailCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: Resources.CellIdentifier.thumbnailCell, for: indexPath) as! ThumbnailCollectionViewCell
        cell.imageView.image = images[indexPath.item]
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension ThumbnailCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedImageIndex = indexPath.item
        imagesView?.updateSelectedImage(index: selectedImageIndex)
    }
}
