//
//  HomeViewModel.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 14.03.2023.
//

import UIKit

protocol HomeViewModelProtocol: AnyObject {
    var userPhoto: UIImage? { get }
    var latestItems: [ShopItemCellViewModel] { get }
    var flashSaleItems: [ShopItemCellViewModel] { get }
    
    func heightForRowAt(tableViewWidth: CGFloat, _ indexPath: IndexPath) -> CGFloat
    func viewFromHeaderInSection(section: Int) -> UIView?
}

final class HomeViewModel {
    
    var userPhoto: UIImage?
    
    var latestItems = [ShopItemCellViewModel]()
    var flashSaleItems = [ShopItemCellViewModel]()
    
    let networkManager: NetworkManagerProtocol = NetworkManager()
    
    private weak var coordinator: HomeCoordinatorProtocol?
    private var userServices: UserServicesProtocol
    
    init(coordinator: HomeCoordinatorProtocol, _ userServices: UserServicesProtocol) {
        self.coordinator = coordinator
        self.userServices = userServices
        
        fetchUserData()
        
    }
    
    private func fetchUserData() {
        guard let userLoggedIn = userServices.userLoggedIn else { return }
        if let imageData = userLoggedIn.image {
            userPhoto = UIImage(data: imageData)
        } else {
            userPhoto = Resources.Images.defaultUserImage
        }
    }
}

// MARK: - ProfileViewModelProtocol

extension HomeViewModel: HomeViewModelProtocol {
    
    func viewFromHeaderInSection(section: Int) -> UIView? {
        guard let sectionType = SectionType(rawValue: section) else { return nil }
        switch sectionType {
        case .latest:
            let header = HeaderView()
            header.setup(with: Constants.latestTitle)
            return header
        case .flashSale:
            let header = HeaderView()
            header.setup(with: Constants.flashSaleTitle)
            return header
        default: return nil
        }
    }
    
    func heightForRowAt(tableViewWidth: CGFloat, _ indexPath: IndexPath) -> CGFloat {
        guard let sectionType = SectionType(rawValue: indexPath.section) else { return 0 }
        
        let itemSize = Constants.calculateItemCollectionViewSize(
            collectionViewWidth: tableViewWidth,
            minimumItemSpacing: sectionType.minimumItemSpacing,
            sectionInset: sectionType.sectionInset,
            itemsCountOnLine: sectionType.itemsCountOnLine,
            aspectRatio: sectionType.aspectRatio
        )
        return itemSize.height + 1
    }
}

// MARK: - SectionType

extension HomeViewModel {
    enum SectionType: Int, CaseIterable {
        case categories, latest, flashSale
        
        var minimumItemSpacing: CGFloat {
            switch self {
            case .categories: return Constants.categoriesItemSpacing
            case .latest: return Constants.latestItemsSpacing
            case .flashSale: return Constants.flashSaleItemsSpacing
            }
        }
        
        var sectionInset: CGFloat {
            switch self {
            case .categories: return Constants.categoriesInsetSpacing
            case .latest: return Constants.latestItemsInsetSpacing
            case .flashSale: return Constants.flashSaleItemsInsetSpacing
            }
        }
        
        var itemsCountOnLine: CGFloat {
            switch self {
            case .categories: return Constants.categoriesCountOnLine
            case .latest: return Constants.latestItemsCountOnLine
            case .flashSale: return Constants.flashSaleItemsCountOnLine
            }
        }
        
        var aspectRatio: CGFloat {
            switch self {
            case .categories: return Constants.categoriesAspectRatio
            case .latest: return Constants.latestItemsAspectRatio
            case .flashSale: return Constants.flashSaleItemsAspectRatio
            }
        }
    }
}

// MARK: - Constants

extension HomeViewModel {
    enum Constants {
        static let title = "Trade by bata"
        static let coloredPartOfTitle = "bata"
        
        static let searchBarPlaceholder = "What are you looking for?"
        
        static let latestTitle = "Latest"
        static let flashSaleTitle = "Flash Sale"
        
        static let categoriesAspectRatio: CGFloat = 5 / 6
        static let latestItemsAspectRatio: CGFloat = 3 / 4
        static let flashSaleItemsAspectRatio: CGFloat = 5 / 6
    
        static let categoriesCountOnLine: CGFloat = 6
        static let categoriesItemSpacing: CGFloat = 0
        static let categoriesInsetSpacing: CGFloat = 10
        
        static let latestItemsCountOnLine: CGFloat = 3
        static let latestItemsSpacing: CGFloat = 12
        static let latestItemsInsetSpacing: CGFloat = 10
        
        static let flashSaleItemsCountOnLine: CGFloat = 2
        static let flashSaleItemsSpacing: CGFloat = 9
        static let flashSaleItemsInsetSpacing: CGFloat = 10
        
        static func calculateItemCollectionViewSize(
            collectionViewWidth: CGFloat,
            minimumItemSpacing: CGFloat,
            sectionInset: CGFloat,
            itemsCountOnLine: CGFloat,
            aspectRatio: CGFloat) -> CGSize {
                let gapItems = minimumItemSpacing * (itemsCountOnLine - 1)
                let gapSection = sectionInset * 2
                let width = (collectionViewWidth - gapItems - gapSection) / itemsCountOnLine
                
                return CGSize(width: width, height: width / aspectRatio)
            }
    }
}
