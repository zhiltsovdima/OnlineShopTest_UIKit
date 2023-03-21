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
    var errorMessage: String? { get }
    var updateCompletion: (() -> Void)? { get set }
    
    func searchTextDidChange(_ searchBar: UISearchBar, _ text: String)
    func fetchData()
    func heightForRowAt(tableViewWidth: CGFloat, _ indexPath: IndexPath) -> CGFloat
    func viewFromHeaderInSection(section: Int) -> UIView?
}

final class HomeViewModel {
    
    var userPhoto: UIImage?
    
    var latestItems = [ShopItemCellViewModel]()
    var flashSaleItems = [ShopItemCellViewModel]()
    var errorMessage: String?
    
    var updateCompletion: (() -> Void)?
    
    let networkManager: NetworkManagerProtocol
    
    private weak var coordinator: HomeCoordinatorProtocol?
    private var userServices: UserServicesProtocol
    
    init(coordinator: HomeCoordinatorProtocol, _ userServices: UserServicesProtocol, _ networkManager: NetworkManagerProtocol) {
        self.coordinator = coordinator
        self.userServices = userServices
        self.networkManager = networkManager
        
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
    
    func fetchData() {
        var latestItems: [ShopItem]?
        var flashSaleItems: [ShopItem]?
        var errorMessage: String?
        
        let group = DispatchGroup()
        
        group.enter()

        networkManager.fetchData(requestType: .latest) { (result: Result<Latest, NetworkError>) in
            switch result {
            case .success(let items):
                latestItems = items.latest
            case .failure(let error):
                errorMessage = error.description
            }
            group.leave()
        }
        
        group.enter()
        networkManager.fetchData(requestType: .flashSale) { (result: Result<FlashSale, NetworkError>) in
            switch result {
            case .success(let items):
                flashSaleItems = items.flashSale
            case .failure(let error):
                errorMessage = error.description
            }
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            guard let self, let latestItems, let flashSaleItems else {
                self?.errorMessage = errorMessage
                self?.updateCompletion?()
                return
            }
            
            let imageGroup = DispatchGroup()
            self.latestItems = latestItems.map {
                ShopItemCellViewModel(self.coordinator, self.networkManager, imageGroup, name: $0.name, category: $0.category, price: $0.price, imageURL: $0.imageUrl)
            }
            
            self.flashSaleItems = flashSaleItems.map {
                ShopItemCellViewModel(self.coordinator, self.networkManager, imageGroup, name: $0.name, category: $0.category, price: $0.price, imageURL: $0.imageUrl, discount: $0.discount)
            }
            imageGroup.notify(queue: .main) {
                self.updateCompletion?()
            }
        }
    }
    
    func searchTextDidChange(_ searchBar: UISearchBar, _ text: String) {
        coordinator?.removeSearchResult()
    
        var searchResults: SearchData?
        let semaphore = DispatchSemaphore(value: 0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.networkManager.fetchData(requestType: .search) { (result: Result<SearchData, NetworkError>) in
                switch result {
                case .success(let searchData):
                    searchResults = searchData
                case .failure(let netError):
                    print(netError.description)
                }
                semaphore.signal()
            }
            semaphore.wait()
            guard let searchResults else { return }
            let foundWords = searchResults.words.filter { $0.range(of: text, options: .caseInsensitive) != nil }
            guard !foundWords.isEmpty else { return }
            self?.coordinator?.showSearchResult(searchBar, foundWords)
        }
    }
    
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
