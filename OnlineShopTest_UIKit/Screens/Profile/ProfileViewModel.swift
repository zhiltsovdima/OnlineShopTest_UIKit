//
//  ProfileViewModel.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 12.03.2023.
//

import UIKit.UIImage

protocol ProfileViewModelProtocol: AnyObject {
    var userName: String? { get }
    var userPhoto: UIImage? { get }
        
    var updateImageCompletion: ((UIImage) -> Void)? { get set }
    
    func uploadItemTapped()
    func numberOfRows() -> Int
    func cellViewModel(for indexPath: IndexPath) -> ProfileCellViewModel
    func didSelectRow(at indexPath: IndexPath)
}

final class ProfileViewModel {
    
    var userName: String?
    var userPhoto: UIImage?
        
    private var cells = [ProfileCellViewModel]()
    
    var updateImageCompletion: ((UIImage) -> Void)?
    
    private weak var coordinator: ProfileCoordinatorProtocol?
    private var userServices: UserServicesProtocol
    
    init(coordinator: ProfileCoordinatorProtocol, _ userServices: UserServicesProtocol) {
        self.coordinator = coordinator
        self.userServices = userServices
        
        fetchUserData()
        setupCells()
    }
    
    private func fetchUserData() {
        userName = userServices.userLoggedIn?.firstName
    }
    
    private func setupCells() {
        cells = [
            ProfileCellViewModel(type: .push, title: "Trade store", iconType: .balance),
            ProfileCellViewModel(type: .push, title: "Payment method", iconType: .balance),
            ProfileCellViewModel(type: .balance, title: "Balance", iconType: .balance, balance: "$ 1593"),
            ProfileCellViewModel(type: .push, title: "Trade history", iconType: .balance),
            ProfileCellViewModel(type: .push, title: "Restore Purchase", iconType: .restore),
            ProfileCellViewModel(type: .normal, title: "Help", iconType: .help),
            ProfileCellViewModel(type: .normal, title: "Log out", iconType: .logout),
        ]
    }
}

// MARK: - ProfileViewModelProtocol

extension ProfileViewModel: ProfileViewModelProtocol {
    
    func uploadItemTapped() {
        coordinator?.showUploadNewPhotoAlert { [weak self] image in
            self?.updateImageCompletion?(image)
        }
    }
    
    func numberOfRows() -> Int {
        return cells.count
    }
    
    func cellViewModel(for indexPath: IndexPath) -> ProfileCellViewModel {
        return cells[indexPath.row]
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        guard cells[indexPath.row].iconType == .logout else { return }
        userServices.userLoggedIn = nil
        coordinator?.logoutTapped()
    }
    
}
