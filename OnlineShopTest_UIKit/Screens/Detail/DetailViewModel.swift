//
//  DetailViewModel.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 19.03.2023.
//

import Foundation

protocol DetailViewModelProtocol {
    
}

final class DetailViewModel {
    
    private weak var coordinator: HomeCoordinatorProtocol?
    private let networkManager: NetworkManagerProtocol
    
    init(coordinator: HomeCoordinatorProtocol, _ networkManager: NetworkManagerProtocol) {
        self.coordinator = coordinator
        self.networkManager = networkManager
        
        fetchUserData()
    }
    
    private func fetchUserData() {
        
    }
}

// MARK: - ProfileViewModelProtocol

extension DetailViewModel: DetailViewModelProtocol {
    
    
}
