//
//  CategoriesCell.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 15.03.2023.
//

import UIKit

final class CategoriesCell: UITableViewCell {
    
    private let categories = [
        ("Phones", Resources.Images.phones),
        ("Headphones", Resources.Images.headphones),
        ("Games", Resources.Images.games),
        ("Cars", Resources.Images.cars),
        ("Furniture", Resources.Images.furniture),
        ("Kids", Resources.Images.kids),
        ("Kids", Resources.Images.kids),
        ("Kids", Resources.Images.kids)
    ]
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
    private var flowLayout = UICollectionViewFlowLayout()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: Resources.CellIdentifier.category)
        collectionView.showsHorizontalScrollIndicator = false
        
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset.right = HomeViewModel.Constants.categoriesInsetSpacing
        flowLayout.sectionInset.left = HomeViewModel.Constants.categoriesInsetSpacing
        flowLayout.minimumLineSpacing = HomeViewModel.Constants.categoriesItemSpacing
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

extension CategoriesCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Resources.CellIdentifier.category, for: indexPath) as! CategoryCell
        cell.setup(with: categories[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoriesCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = HomeViewModel.Constants.calculateItemCollectionViewSize(
            collectionViewWidth: collectionView.bounds.width,
            minimumItemSpacing: HomeViewModel.Constants.categoriesItemSpacing,
            sectionInset: HomeViewModel.Constants.categoriesInsetSpacing,
            itemsCountOnLine: HomeViewModel.Constants.categoriesCountOnLine,
            aspectRatio: HomeViewModel.Constants.categoriesAspectRatio)
        return itemSize
    }
}


