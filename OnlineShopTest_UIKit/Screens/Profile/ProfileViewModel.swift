//
//  ProfileViewModel.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 12.03.2023.
//

import Foundation

protocol ProfileViewModelProtocol {
    func uploadItemTapped()
}

final class ProfileViewModel {
    
    private weak var coordinator: ProfileCoordinatorProtocol?
    private var userServices: UserServicesProtocol
    
    init(coordinator: ProfileCoordinatorProtocol, _ userServices: UserServicesProtocol) {
        self.coordinator = coordinator
        self.userServices = userServices
    }
    
}

// MARK: - ProfileViewModelProtocol

extension ProfileViewModel: ProfileViewModelProtocol {
    
    func uploadItemTapped() {
        
    }
    
    func logOutTapped() {
        
    }
}
