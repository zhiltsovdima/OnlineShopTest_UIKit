//
//  ShopItem.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 15.03.2023.
//

import Foundation

struct FlashSale: Codable {
    let flashSale: [ShopItem]
    
    enum CodingKeys: String, CodingKey {
        case flashSale = "flash_sale"
    }
}

struct Latest: Codable {
    let latest: [ShopItem]
    
    enum CodingKeys: String, CodingKey {
        case latest
    }
}


struct ShopItem {
    let id = UUID().uuidString
    
    let name: String
    let category: String
    let price: Double
    let imageUrl: URL
    let discount: Int?

}

extension ShopItem: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case category
        case price
        case imageUrl = "image_url"
        case discount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decode(String.self, forKey: .category)
        self.price = try container.decode(Double.self, forKey: .price)
        self.imageUrl = try container.decode(URL.self, forKey: .imageUrl)
        self.discount = try container.decodeIfPresent(Int.self, forKey: .discount)
    }
}
