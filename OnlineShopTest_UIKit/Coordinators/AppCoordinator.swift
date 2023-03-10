//
//  AppCoordinator.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 10.03.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    func start()
    func childDidFinish(_ coordinator: Coordinator)
}

extension Coordinator {
    func childDidFinish(_ coordinator: Coordinator) {
        childCoordinators.removeAll(where: { $0 === coordinator })
    }
}

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    private let navigationController: UINavigationController
    private let window: UIWindow
    
    private var authCoordinator: AuthCoordinator?
    
    init(_ window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
    }
    
    func start() {
        showAuth()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func showAuth() {
        let authCoordinator = AuthCoordinator(navigationController)
        self.authCoordinator = authCoordinator
        authCoordinator.start()
        childCoordinators.append(self)
    }
}
