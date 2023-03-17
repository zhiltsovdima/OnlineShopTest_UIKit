//
//  ShopItemCellViewModel.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 16.03.2023.
//

import UIKit

final class ShopItemCellViewModel {
    
    let name: String
    let category: String
    let price: String
    var image: UIImage?
    let discount: String?
    
    private let imageURL: URL
    private let networkManager: NetworkManagerProtocol
    
    init(_ networkManager: NetworkManagerProtocol, _ imageGroup: DispatchGroup, name: String, category: String, price: Double, imageURL: URL, discount: Int?) {
        self.networkManager = networkManager
        self.name = name
        self.category = category
        self.price = String(format: "$ %.2f", price)
        self.imageURL = imageURL
        self.discount = discount != nil ? "\(discount!)% off" : nil
        
        updateImage(imageGroup)
    }
    
    func updateImage(_ imageGroup: DispatchGroup) {
        imageGroup.enter()
        networkManager.fetchImage(from: imageURL) { [weak self] result in
            switch result {
            case .success(let fetchedImage):
                self?.image = fetchedImage
            case .failure(let error):
                print(error.description)
            }
            imageGroup.leave()
        }
    }
    
}
