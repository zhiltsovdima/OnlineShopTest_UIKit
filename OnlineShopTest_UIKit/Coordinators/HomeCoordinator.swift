//
//  HomeCoordinator.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 12.03.2023.
//

import UIKit

protocol HomeCoordinatorProtocol: AnyObject {
    func showSearchResult(_ sourceView: UISearchBar, _ items: [String])
    func removeSearchResult()
    func showDetail()
}

final class HomeCoordinator: NSObject, Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: TabBarCoordinator?
    
    private let navigationController: UINavigationController
    private let userServices: UserServicesProtocol
    private let networkManager: NetworkManagerProtocol
    
    init(_ navigationController: UINavigationController,
         _ userServices: UserServicesProtocol,
         _ networkManager: NetworkManagerProtocol) {
        self.navigationController = navigationController
        self.userServices = userServices
        self.networkManager = networkManager
    }
    
    func start() {
        let viewModel = HomeViewModel(coordinator: self, userServices, networkManager)
        let homeController = HomeController(viewModel: viewModel)
        navigationController.pushViewController(homeController, animated: false)
    }
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    
    func showSearchResult(_ sourceView: UISearchBar, _ items: [String]) {

        let searchResultView = SearchResultsController(sourceView, items)
        searchResultView.modalPresentationStyle = .popover
        
        guard let popoverVC = searchResultView.popoverPresentationController else { return }
        popoverVC.delegate = self
        popoverVC.sourceView = sourceView
        popoverVC.sourceRect = CGRect(x: sourceView.searchTextField.frame.minX,
                                       y: sourceView.searchTextField.frame.maxY,
                                       width: sourceView.searchTextField.frame.width,
                                       height: 0
        )
        popoverVC.permittedArrowDirections = .up
        popoverVC.passthroughViews = [sourceView]

        searchResultView.preferredContentSize.width = sourceView.searchTextField.frame.width
        
        navigationController.present(searchResultView, animated: true)
    }
    
    func removeSearchResult() {
        navigationController.dismiss(animated: true)
    }
    
    func showDetail() {
        let viewModel = DetailViewModel(coordinator: self, networkManager)
        let detailController = DetailController(viewModel)
        navigationController.pushViewController(detailController, animated: true)
    }
}

extension HomeCoordinator: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}


