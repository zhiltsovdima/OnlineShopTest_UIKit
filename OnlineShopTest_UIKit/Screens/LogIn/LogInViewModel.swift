//
//  LogInViewModel.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 11.03.2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol LogInViewModelProtocol: AnyObject {
    var errorMessageRelay: BehaviorRelay<String?> { get }
    func logInTapped(name: String?, password: String?)
}

final class LogInViewModel {
        
    let errorMessageRelay = BehaviorRelay<String?>(value: nil)
    
    private weak var coordinator: AuthCoordinatorProtocol?
    private let userServices: UserServicesProtocol
    
    init(coordinator: AuthCoordinatorProtocol, userServices: UserServicesProtocol) {
        self.coordinator = coordinator
        self.userServices = userServices
    }
    
    private func isNonEmpty(_ field: String?) -> Bool {
        guard let field else { return false }
        return !field.isEmpty
    }
}

// MARK: - LogInViewModelProtocol

extension LogInViewModel: LogInViewModelProtocol {
    
    func logInTapped(name: String?, password: String?) {
        guard isNonEmpty(name), isNonEmpty(password) else {
            errorMessageRelay.accept(UserAuthError.emptyData.description)
            return
        }
        guard let user = userServices.getUsers().first(where: { $0.firstName == name }) else {
            errorMessageRelay.accept(UserAuthError.userDoesntExist.description)
            return
        }
        userServices.setLoggedInUser(user)
        coordinator?.successLogIn()
    }
}
