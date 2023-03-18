//
//  APIEndpoints.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 15.03.2023.
//

import Foundation

enum APIEndpoints {
    case latest
    case flashSale
    case search
    
    private var stringURL: String {
        switch self {
        case .latest: return "https://run.mocky.io/v3/cc0071a1-f06e-48fa-9e90-b1c2a61eaca7"
        case .flashSale: return "https://run.mocky.io/v3/a9ceeb6e-416d-4352-bde6-2203416576ac"
        case .search: return "https://run.mocky.io/v3/4c9cd822-9479-4509-803d-63197e5a9e19"
        }
    }
    
}

extension APIEndpoints {
    
    func makeURLRequest() -> URLRequest {
        let url = URL(string: stringURL)!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
