//
//  FlashSaleItemsCell.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 15.03.2023.
//

import UIKit

final class FlashSaleItemsCell: UITableViewCell {
    
    private var shopItems = [ShopItemCellViewModel]()
    
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
    
    func setup(with shopItems: [ShopItemCellViewModel]) {
        self.shopItems = shopItems
    }
    
    private func setupViews() {
        backgroundColor = Resources.Colors.background
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = Resources.Colors.background
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FlashSaleCell.self, forCellWithReuseIdentifier: Resources.CellIdentifier.flashSale)
        collectionView.showsHorizontalScrollIndicator = false
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset.right = HomeViewModel.Constants.flashSaleItemsInsetSpacing
        flowLayout.sectionInset.left = HomeViewModel.Constants.flashSaleItemsInsetSpacing
        flowLayout.minimumLineSpacing = HomeViewModel.Constants.flashSaleItemsSpacing
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

extension FlashSaleItemsCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Resources.CellIdentifier.flashSale, for: indexPath) as! FlashSaleCell
        cell.setup(with: shopItems[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension FlashSaleItemsCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = HomeViewModel.Constants.calculateItemCollectionViewSize(
            collectionViewWidth: collectionView.bounds.width,
            minimumItemSpacing: HomeViewModel.Constants.flashSaleItemsSpacing,
            sectionInset: HomeViewModel.Constants.flashSaleItemsInsetSpacing,
            itemsCountOnLine: HomeViewModel.Constants.flashSaleItemsCountOnLine,
            aspectRatio: HomeViewModel.Constants.flashSaleItemsAspectRatio)
        return itemSize
    }
}
