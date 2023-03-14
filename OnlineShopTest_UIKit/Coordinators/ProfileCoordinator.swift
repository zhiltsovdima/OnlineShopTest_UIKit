//
//  ProfileCoordinator.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 12.03.2023.
//

import UIKit

protocol ImagePickable {
    func showImagePicker(sourceType: UIImagePickerController.SourceType)
    func didFinishPicking(_ image: UIImage)
}

protocol ProfileCoordinatorProtocol: AnyObject {
    func showUploadNewPhotoAlert(completion: @escaping (UIImage) -> Void)
    func logoutTapped()
}

final class ProfileCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: TabBarCoordinator?
    
    private var completion: ((UIImage) -> Void)?
    
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
    
    func showUploadNewPhotoAlert(completion: @escaping (UIImage) -> Void) {
        self.completion = completion
        let choosePhotoAlertCoordinator = AlertCoordinator(navigationController)
        choosePhotoAlertCoordinator.parentCoordinator = self
        choosePhotoAlertCoordinator.start()
        childCoordinators.append(choosePhotoAlertCoordinator)
    }
    
    func logoutTapped() {
        parentCoordinator?.childDidFinish(self)
        parentCoordinator?.logout()
    }
}

extension ProfileCoordinator: ImagePickable {
    
    func showImagePicker(sourceType: UIImagePickerController.SourceType) {
        let imagePickerCoordinator = ImagePickerCoordinator(navigationController, sourceType: sourceType)
        imagePickerCoordinator.parentCoordinator = self
        imagePickerCoordinator.start()
        childCoordinators.append(imagePickerCoordinator)
    }
    
    func didFinishPicking(_ image: UIImage) {
        completion?(image)
    }
    
    
}
