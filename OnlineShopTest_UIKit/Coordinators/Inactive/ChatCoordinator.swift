//
//  ChatCoordinator.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 12.03.2023.
//

import UIKit

final class ChatCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let chatController = UIViewController()
        chatController.view.backgroundColor = .white
        navigationController.pushViewController(chatController, animated: false)
    }

}
