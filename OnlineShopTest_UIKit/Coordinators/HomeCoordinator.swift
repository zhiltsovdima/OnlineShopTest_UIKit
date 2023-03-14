//
//  HomeCoordinator.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 12.03.2023.
//

import UIKit

protocol HomeCoordinatorProtocol: AnyObject {
    
}

final class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: TabBarCoordinator?
    
    private let navigationController: UINavigationController
    private let userServices: UserServicesProtocol
    
    init(_ navigationController: UINavigationController, _ userServices: UserServicesProtocol) {
        self.navigationController = navigationController
        self.userServices = userServices
    }
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self, userServices)
        let homeController = HomeController(viewModel: viewModel)
        navigationController.pushViewController(homeController, animated: false)
    }
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    
}
