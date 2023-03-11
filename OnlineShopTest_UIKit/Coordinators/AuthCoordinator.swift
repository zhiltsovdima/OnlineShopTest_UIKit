//
//  AuthCoordinator.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 10.03.2023.
//

import UIKit

protocol AuthCoordinatorProtocol: AnyObject {
    func showLogIn()
    func successLogIn()
}

final class AuthCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let userServices = UserServices(coreDataManager: CoreDataManager())
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SignInViewModel(coordinator: self, userServices: userServices)
        let signInController = SignInController(viewModel: viewModel)
        navigationController.pushViewController(signInController, animated: true)
    }
    
}

extension AuthCoordinator: AuthCoordinatorProtocol {
    
    func showLogIn() {
        let viewModel = LogInViewModel(coordinator: self, userServices: userServices)
        let logInController = LogInController(viewModel: viewModel)
        navigationController.pushViewController(logInController, animated: true)
    }
    
    func successLogIn() {
        
    }
}
