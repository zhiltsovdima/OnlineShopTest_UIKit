//
//  AlertCoordinator.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 13.03.2023.
//

import UIKit

final class AlertCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    
    private var navigationController: UINavigationController
    
    init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        if let parent = parentCoordinator as? (ImagePickable & Coordinator) {
            createPhotoChooseAlert(for: parent)
        }
    }
    
    private func showAlertController(title: String?, message: String?, preferredStyle: UIAlertController.Style, actions: [UIAlertAction]) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        actions.forEach(alertController.addAction)
        navigationController.visibleViewController?.present(alertController, animated: true)
    }
    
    private func createPhotoChooseAlert(for parent: ImagePickable & Coordinator) {
        let cameraAction = UIAlertAction(title: Constants.cameraTitle, style: .default) { _ in
            parent.showImagePicker(sourceType: .camera)
            parent.childDidFinish(self)
        }
        let photoLibraryAction = UIAlertAction(title: Constants.photoLibraryTitle, style: .default) { _ in
            parent.showImagePicker(sourceType: .photoLibrary)
            parent.childDidFinish(self)
        }
        let cancelAction = UIAlertAction(title: Constants.cancelTitle, style: .cancel) { _ in
            parent.childDidFinish(self)
        }
        showAlertController(
            title: Constants.alertTitle,
            message: nil,
            preferredStyle: .actionSheet,
            actions: [
                cameraAction,
                photoLibraryAction,
                cancelAction
            ]
        )
    }
}

extension AlertCoordinator {
    private enum Constants {
        static let alertTitle = "Choose your image"
        static let cameraTitle = "Take a photo"
        static let photoLibraryTitle = "Open the photo library"
        static let cancelTitle = "Cancel"
    }
}
