//
//  DetailViewModel.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 19.03.2023.
//

import UIKit.UIColor

protocol DetailViewModelProtocol: AnyObject {
    var detailData: DetailModel? { get }
    var errorMessage: String? { get }
    var updateCompletion: (() -> Void)? { get set }
    var updateImagesCompletion: (() -> Void)? { get set }
    
    func fetchData()
    func stepperValueChanged(_ value: Int)
    func backToHome()
}

final class DetailViewModel {
    
    var detailData: DetailModel?
    var errorMessage: String?
    
    var updateCompletion: (() -> Void)?
    var updateImagesCompletion: (() -> Void)?
    
    private weak var coordinator: HomeCoordinatorProtocol?
    private let networkManager: NetworkManagerProtocol
    
    init(coordinator: HomeCoordinatorProtocol, _ networkManager: NetworkManagerProtocol) {
        self.coordinator = coordinator
        self.networkManager = networkManager
    }
}

// MARK: - ProfileViewModelProtocol

extension DetailViewModel: DetailViewModelProtocol {
    
    func fetchData() {
        networkManager.fetchData(requestType: .detail) { [weak self] (result: Result<ShopItem, NetworkError>) in
            guard let self else { return }
            switch result {
            case .success(let shopItem):
                let detailData = DetailModel(
                    name: shopItem.name,
                    description: shopItem.description ?? "No data",
                    priceDouble: shopItem.price,
                    rating: String(format: "%.1f", shopItem.rating ?? 0),
                    reviews: "(\(shopItem.numberOfReviews ?? 0) reviews)",
                    colors: shopItem.colors?.compactMap { UIColor(hexString: $0) }
                )
                self.detailData = detailData
                self.fetchImages(from: shopItem.imageUrls)
            case .failure(let error):
                self.errorMessage = error.description
            }
            DispatchQueue.main.async {
                self.updateCompletion?()
            }
        }
    }
    
    private func fetchImages(from urls: [URL]?) {
        guard let urls, !urls.isEmpty else { return }
        var images = [UIImage]()
        var errorMessage: String?
        
        let dispathGroup = DispatchGroup()
        urls.forEach {
            dispathGroup.enter()
            networkManager.fetchImage(from: $0) { result in
                switch result {
                case .success(let image):
                    images.append(image)
                case .failure(let error):
                    errorMessage = error.description
                }
                dispathGroup.leave()
            }
        }
        dispathGroup.notify(queue: .main) { [weak self] in
            guard let self else { return }
            if let errorMessage {
                self.errorMessage = errorMessage
            } else {
                self.detailData?.images = images
            }
            self.updateImagesCompletion?()
        }
    }
    
    func stepperValueChanged(_ value: Int) {
        detailData?.count = value
        updateCompletion?()
    }
    
    func backToHome() {
        coordinator?.backToHome()
    }
}
