//
//  ProfileCoordinator.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 12.03.2023.
//

import UIKit

protocol ProfileCoordinatorProtocol: AnyObject {
    func logoutTapped()
}

final class ProfileCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: TabBarCoordinator?
    
    private let navigationController: UINavigationController
    private let userServices: UserServicesProtocol
    
    init(_ navigationController: UINavigationController, _ userServices: UserServicesProtocol) {
        self.navigationController = navigationController
        self.userServices = userServices
    }
    
    func start() {
        let viewModel = ProfileViewModel(coordinator: self, userServices)
        let profileController = ProfileController(viewModel: viewModel)
        navigationController.pushViewController(profileController, animated: false)
    }
}

extension ProfileCoordinator: ProfileCoordinatorProtocol {
    
    func logoutTapped() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.logout()
    }
}
