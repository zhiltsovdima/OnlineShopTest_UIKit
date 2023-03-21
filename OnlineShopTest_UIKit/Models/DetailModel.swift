//
//  DetailModel.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 20.03.2023.
//

import UIKit.UIColor

struct DetailModel {
    let name: String
    let description: String
    let priceDouble: Double
    let rating: String
    let reviews: String
    let colors: [UIColor]?
    var images: [UIImage]?
    var count = 1
    var price: String {
        String(format: "$ %.2f", priceDouble)
    }
    var fullPrice: String {
        String(format: "$ %.2f", priceDouble * Double(count))
    }
}
