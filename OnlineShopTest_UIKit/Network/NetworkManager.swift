//
//  NetworkManager.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 15.03.2023.
//

import UIKit

enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

// MARK: - NetworkManager

class NetworkManager: NetworkManagerProtocol {
    
    private var imageCache = NSCache<NSURL, UIImage>()
    
    private let urlSession: URLSessionProtocol
    
    init(urlSession: URLSessionProtocol = URLSession.shared) {
        self.urlSession = urlSession
    }
    
    func fetchData<T: Decodable>(requestType: APIEndpoints, completion: @escaping (Result<T, NetworkError>) -> Void) {
        let request = requestType.makeURLRequest()
        let task = urlSession.dataTask(with: request) { [weak self] (data, response, error) in
            guard let self else { return completion(Result.failure(NetworkError.failed))}
            do {
                let safeData = try NetworkError.processResponseData(data, response)
                let result = self.parseData(T.self, safeData)
                completion(result)
            } catch {
                let netError = error as! NetworkError
                completion(.failure(netError))
            }
        }
        task.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (Result<UIImage, NetworkError>) -> Void) {
        if let cachedImage = imageCache.object(forKey: url as NSURL) {
            completion(.success(cachedImage))
            return
        }
        let task = urlSession.dataTask(with: url) { [weak self] data, response, error in
            guard let self else { return completion(Result.failure(NetworkError.failed))}
            do {
                let safeData = try NetworkError.processResponseData(data, response)
                guard let image = UIImage(data: safeData) else {
                    completion(.failure(NetworkError.unableToDecode))
                    return
                }
                self.imageCache.setObject(image, forKey: url as NSURL)
                completion(.success(image))
            } catch {
                let netError = error as! NetworkError
                completion(.failure(netError))
            }
        }
        task.resume()
    }
}

extension NetworkManager: NetworkManagerDataParser {
    
    func parseData<T: Decodable>(_ type: T.Type, _ data: Data) -> Result<T, NetworkError> {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return .success(decodedData)
        } catch {
            return .failure(.unableToDecode)
        }
    }
}
