//
//  NetworkProtocols.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 15.03.2023.
//

import UIKit.UIImage

protocol NetworkManagerProtocol {
    func fetchData(requestType: APIEndpoints, completion: @escaping (Result<[ShopItem], NetworkError>) -> Void)
    func fetchImage(from url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void)
}

protocol NetworkManagerDataParser {
    func parseShopItems(_ type: APIEndpoints, _ data: Data) -> Result<[ShopItem], NetworkError>
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
    func dataTask(with: URL, completionHandler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}
