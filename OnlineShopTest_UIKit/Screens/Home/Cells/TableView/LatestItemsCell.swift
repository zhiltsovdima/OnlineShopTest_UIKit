//
//  LatestItemsCell.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 15.03.2023.
//

import UIKit

final class LatestItemsCell: UITableViewCell {
    
    private var shopItems = [ShopItemCellViewModelProtocol]()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private let flowLayout = UICollectionViewFlowLayout()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with shopItems: [ShopItemCellViewModelProtocol]) {
        self.shopItems = shopItems
    }
    
    private func setupViews() {
        backgroundColor = Resources.Colors.background
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = Resources.Colors.background
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LatestCell.self, forCellWithReuseIdentifier: Resources.CellIdentifier.latest)
        collectionView.showsHorizontalScrollIndicator = false
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset.right = HomeViewModel.Constants.latestItemsInsetSpacing
        flowLayout.sectionInset.left = HomeViewModel.Constants.latestItemsInsetSpacing
        flowLayout.minimumLineSpacing = HomeViewModel.Constants.latestItemsSpacing
    }
    
    private func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension LatestItemsCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Resources.CellIdentifier.latest, for: indexPath) as! LatestCell
        cell.setup(with: shopItems[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LatestItemsCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = HomeViewModel.Constants.calculateItemCollectionViewSize(
            collectionViewWidth: collectionView.bounds.width,
            minimumItemSpacing: HomeViewModel.Constants.latestItemsSpacing,
            sectionInset: HomeViewModel.Constants.latestItemsInsetSpacing,
            itemsCountOnLine: HomeViewModel.Constants.latestItemsCountOnLine,
            aspectRatio: HomeViewModel.Constants.latestItemsAspectRatio)
        return itemSize
    }
}
