//
//  AuthCoordinator.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 10.03.2023.
//

import UIKit

protocol AuthCoordinatorProtocol: AnyObject {
    
}

final class AuthCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = SignInViewModel(coordinator: self)
        let signInController = SignInController(viewModel: viewModel)
        navigationController.pushViewController(signInController, animated: true)
    }
    
}

extension AuthCoordinator: AuthCoordinatorProtocol {
    
}
