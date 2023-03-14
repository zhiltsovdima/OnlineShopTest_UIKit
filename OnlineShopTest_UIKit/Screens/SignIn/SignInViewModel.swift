//
//  SignInViewModel.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 10.03.2023.
//

import Foundation
import RxSwift
import RxCocoa

protocol SignInViewModelProtocol: AnyObject {
    var errorMessageRelay: BehaviorRelay<String?> { get }
    func signInTapped(firstName: String?, lastName: String?, email: String?)
    func logInTapped()
}

final class SignInViewModel {
        
    let errorMessageRelay = BehaviorRelay<String?>(value: nil)
    
    private weak var coordinator: AuthCoordinatorProtocol?
    private let userServices: UserServicesProtocol
    
    init(coordinator: AuthCoordinatorProtocol, userServices: UserServicesProtocol) {
        self.coordinator = coordinator
        self.userServices = userServices
    }
    
    private func validateUserData(firstName: String, lastName: String, email: String) throws {
        guard isValidName(firstName) else { throw UserAuthError.firstNameEmpty }
        guard isValidName(lastName) else { throw UserAuthError.lastNameEmpty }
        guard isValidEmail(email) else { throw UserAuthError.incorrectEmail }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidName(_ name: String) -> Bool {
        return name.isEmpty ? false : true
    }
}

// MARK: - SignInViewModelProtocol

extension SignInViewModel: SignInViewModelProtocol {
    
    func signInTapped(firstName: String?, lastName: String?, email: String?) {
        guard let firstName, let lastName, let email else {
            errorMessageRelay.accept(UserAuthError.emptyData.description)
            return
        }
        do {
            try validateUserData(firstName: firstName, lastName: lastName, email: email)
            if let _ = userServices.getUsers().first(where: { $0.firstName == firstName && $0.lastName == lastName && $0.email == email }) {
                errorMessageRelay.accept(UserAuthError.userAlreadyExist.description)
                return
            }
            let user = try userServices.saveUser(data: UserServices.UserDataInput(
                firstName: firstName,
                lastName: lastName,
                email: email,
                image: nil)
            )
            errorMessageRelay.accept(nil)
            userServices.setLoggedInUser(user)
            coordinator?.successLogIn()
        } catch {
            if let authError = error as? UserAuthError {
                errorMessageRelay.accept(authError.description)
            }
        }
    }
    
    func logInTapped() {
        coordinator?.showLogIn()
    }
}
