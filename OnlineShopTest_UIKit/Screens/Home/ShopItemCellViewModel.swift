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
    let image: UIImage?
    let discount: String?
    
    init(name: String, category: String, price: String, image: UIImage?, discount: String?) {
        self.name = name
        self.category = category
        self.price = price
        self.image = image
        self.discount = discount
    }
    
}
