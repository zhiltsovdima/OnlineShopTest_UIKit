//
//  ShopItemCellViewModel.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 16.03.2023.
//

import UIKit

protocol ShopItemCellViewModelProtocol {
    var name: String { get }
    var category: String? { get }
    var price: String { get }
    var image: UIImage? { get }
    var discount: String? { get }
    
    func updateImage(_ imageGroup: DispatchGroup)
    func showDetail()
}

final class ShopItemCellViewModel {
    
    let name: String
    let category: String?
    let price: String
    var image: UIImage?
    let discount: String?
    
    private let imageURL: URL?
    private let networkManager: NetworkManagerProtocol
    private weak var coordinator: HomeCoordinatorProtocol?
    
    init(_ coordinator: HomeCoordinatorProtocol?, _ networkManager: NetworkManagerProtocol, _ imageGroup: DispatchGroup, name: String, category: String?, price: Double, imageURL: URL?, discount: Int? = nil) {
        self.coordinator = coordinator
        self.networkManager = networkManager
        self.name = name
        self.category = category
        self.price = String(format: "$ %.2f", price)
        self.imageURL = imageURL
        self.discount = discount != nil ? "\(discount!)% off" : nil
        
        updateImage(imageGroup)
    }
}

// MARK: - ShopItemCellViewModelProtocol

extension ShopItemCellViewModel: ShopItemCellViewModelProtocol {
    
    func updateImage(_ imageGroup: DispatchGroup) {
        guard let imageURL else { return }
        imageGroup.enter()
        networkManager.fetchImage(from: imageURL) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let fetchedImage):
                self.image = fetchedImage
            case .failure(let error):
                print(error.description)
            }
            imageGroup.leave()
        }
    }
    
    func showDetail() {
        coordinator?.showDetail()
    }
}
