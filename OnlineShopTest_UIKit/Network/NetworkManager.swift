//
//  NetworkManager.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 15.03.2023.
//

import Foundation

enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

// MARK: - NetworkManager

class NetworkManager: NetworkManagerProtocol {
    
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchData(requestType: APIEndpoints, completion: @escaping (Result<[ShopItem], NetworkError>) -> Void) {
        let request = requestType.makeURLRequest()
        let task = urlSession.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self else { return completion(Result.failure(NetworkError.failed))}
            do {
                let safeData = try NetworkError.handleNetworkResponse(data, response)
                let result = self.parseShopItems(requestType, safeData)
                completion(result)
            } catch {
                let netError = error as! NetworkError
                completion(.failure(netError))
            }
        }
        task.resume()
    }
}

extension NetworkManager: NetworkManagerDataParser {
    
    private func parseData<T: Decodable>(_ type: T.Type, _ data: Data) -> Result<T, NetworkError> {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(.unableToDecode)
        }
    }
    
    func parseShopItems(_ type: APIEndpoints, _ data: Data) -> Result<[ShopItem], NetworkError> {
        switch type {
        case .latest:
            let result = parseData(Latest.self, data)
            switch result {
            case .success(let latestData):
                return .success(latestData.latest)
            case .failure(let netError):
                return .failure(netError)
            }
        case .flashSale:
            let result = parseData(FlashSale.self, data)
            switch result {
            case .success(let flashSaleData):
                return .success(flashSaleData.flashSale)
            case .failure(let netError):
                return .failure(netError)
            }
        }
    }
}
