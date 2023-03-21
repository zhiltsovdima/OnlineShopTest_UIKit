//
//  NetworkManagerMock.swift
//  OnlineShopTest_UIKitTests
//
//  Created by Dima Zhiltsov on 21.03.2023.
//

import UIKit
@testable import OnlineShopTest_UIKit

final class NetworkManagerMock: NetworkManagerProtocol {
    
    var dataResult: Result<ShopItem, NetworkError>?
    var imageResult: Result<UIImage, NetworkError>?
    
    func fetchData<T: Decodable>(requestType: APIEndpoints, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let dataResult else { return }
        switch dataResult {
        case .success(let item):
            completion(.success(item as! T))
        case .failure(let error):
            completion(.failure(error))
        }
    }

    func fetchImage(from url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageResult else { return }
        switch imageResult {
        case .success(let image):
            completion(.success(image))
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

