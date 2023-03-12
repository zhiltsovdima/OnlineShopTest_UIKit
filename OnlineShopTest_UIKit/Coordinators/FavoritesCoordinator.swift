//
//  FavoritesCoordinator.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 12.03.2023.
//

import UIKit

final class FavoritesCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let favoritesController = UIViewController()
        favoritesController.view.backgroundColor = .white
        navigationController.pushViewController(favoritesController, animated: false)
    }

}
