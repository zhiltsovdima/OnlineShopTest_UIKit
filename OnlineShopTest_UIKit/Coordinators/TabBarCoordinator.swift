//
//  TabBarCoordinator.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 12.03.2023.
//

import UIKit

final class TabBarCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    var parentCoordinator: AppCoordinator?
    
    private let tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
    }
    
    func start() {
        let pages: [TabBarPage] = [.home, .favorites, .cart, .chat, .profile]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        let controllers = pages.map { getController(for: $0)}
        prepareTabBarController(with: controllers)
    }
    
    private func getController(for page: TabBarPage) -> UINavigationController {
        let navigationController = UINavigationController()
        navigationController.tabBarItem = UITabBarItem(title: nil,
                                                       image: page.pageIcon(),
                                                       tag: page.pageOrderNumber())
        let childCoordinator = getChildCoordinator(for: page, navigationController)
        childCoordinator.start()
        childCoordinators.append(childCoordinator)
        return navigationController
    }
    
    private func getChildCoordinator(for page: TabBarPage, _ navigationController: UINavigationController) -> Coordinator {
        switch page {
        case .profile:
            return ProfileCoordinator(navigationController)
        case .chat:
            return ChatCoordinator(navigationController)
        case .cart:
            return CartCoordinator(navigationController)
        case .favorites:
            return ProfileCoordinator(navigationController)
        case .home:
            return HomeCoordinator(navigationController)
        }
    }
    
    private func prepareTabBarController(with controllers: [UIViewController]) {
        tabBarController.setViewControllers(controllers, animated: false)
        tabBarController.tabBar.backgroundColor = Resources.Colors.white
        tabBarController.tabBar.tintColor = Resources.Colors.tabBarTint
    }
}

// MARK: - TabBarPage

enum TabBarPage {
    case home
    case favorites
    case cart
    case chat
    case profile
    
    func pageOrderNumber() -> Int {
        switch self {
        case .home:
            return 0
        case .favorites:
            return 1
        case .cart:
            return 2
        case .chat:
            return 3
        case .profile:
            return 4
        }
    }
    
    func pageIcon() -> UIImage? {
        switch self {
        case .home:
            return Resources.Images.TabBar.home
        case .favorites:
            return Resources.Images.TabBar.favorites
        case .cart:
            return Resources.Images.TabBar.cart
        case .chat:
            return Resources.Images.TabBar.chat
        case .profile:
            return Resources.Images.TabBar.profile
        }
    }
}
