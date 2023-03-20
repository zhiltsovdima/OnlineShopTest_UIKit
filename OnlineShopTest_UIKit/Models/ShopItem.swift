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
    let category: String?
    let description: String?
    let rating: Double?
    let numberOfReviews: Int?
    let price: Double
    let colors: [String]?
    let imageUrl: URL?
    let imageUrls: [URL]?
    let discount: Int?

}

extension ShopItem: Codable {
    
    enum CodingKeys: String, CodingKey {
        case name
        case category
        case description
        case rating
        case numberOfReviews = "number_of_reviews"
        case price
        case colors
        case imageUrl = "image_url"
        case imageUrls = "image_urls"
        case discount
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
        self.description = try container.decodeIfPresent(String.self, forKey: .description)
        self.rating = try container.decodeIfPresent(Double.self, forKey: .rating)
        self.numberOfReviews = try container.decodeIfPresent(Int.self, forKey: .numberOfReviews)
        self.price = try container.decode(Double.self, forKey: .price)
        self.colors = try container.decodeIfPresent([String].self, forKey: .colors)
        self.imageUrl = try container.decodeIfPresent(URL.self, forKey: .imageUrl)
        self.imageUrls = try container.decodeIfPresent([URL].self, forKey: .imageUrls)
        self.discount = try container.decodeIfPresent(Int.self, forKey: .discount)
    }
}
