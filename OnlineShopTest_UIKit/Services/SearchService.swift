//
//  SearchService.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 05.04.2023.
//

import Foundation

protocol SearchServiceProtocol {
    func search(for text: String, completion: @escaping ([String]) -> Void)
}

final class SearchService: SearchServiceProtocol {
    
    private let networkManager: NetworkManagerProtocol
    private var searchTask: DispatchWorkItem?
    
    init(_ networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func search(for text: String, completion: @escaping ([String]) -> Void) {
        searchTask?.cancel()
        
        let newSearchTask = DispatchWorkItem { [weak self] in
            self?.networkManager.fetchData(requestType: .search, completion: { (result: Result<SearchData, NetworkError>) in
                switch result {
                case .success(let searchData):
                    let foundWords = searchData.words.filter { $0.range(of: text, options: .caseInsensitive) != nil }
                    completion(foundWords)
                case .failure(let netError):
                    print(netError.description)
                }
            })
        }
        searchTask = newSearchTask
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: newSearchTask)
    }
}
