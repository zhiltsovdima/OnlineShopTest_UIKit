//
//  HomeViewModel.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 14.03.2023.
//

import UIKit.UIImage

protocol HomeViewModelProtocol: AnyObject {
    var userPhoto: UIImage? { get }
}

final class HomeViewModel {
    
    var userPhoto: UIImage?
    
    private weak var coordinator: HomeCoordinatorProtocol?
    private var userServices: UserServicesProtocol
    
    init(coordinator: HomeCoordinatorProtocol, _ userServices: UserServicesProtocol) {
        self.coordinator = coordinator
        self.userServices = userServices
        
        fetchUserData()
    }
    
    private func fetchUserData() {
        guard let userLoggedIn = userServices.userLoggedIn else { return }
        if let imageData = userLoggedIn.image {
            userPhoto = UIImage(data: imageData)
        } else {
            userPhoto = Resources.Images.defaultUserImage
        }
    }
    
    
}

// MARK: - ProfileViewModelProtocol

extension HomeViewModel: HomeViewModelProtocol {
    
    
    
}
