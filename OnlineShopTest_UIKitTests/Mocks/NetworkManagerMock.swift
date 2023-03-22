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
        guard let dataResult = dataResult as? Result<T, NetworkError> else { return }
        completion(dataResult)
    }

    func fetchImage(from url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        guard let imageResult else { return }
        completion(imageResult)
    }
}

