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
    
    private func isValidEmail(_ email: String?) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func isValidName(_ name: String?) -> Bool {
        guard let name else { return false }
        return name.isEmpty ? false : true
    }
}

extension SignInViewModel: SignInViewModelProtocol {
    
    func signInTapped(firstName: String?, lastName: String?, email: String?) {
        guard isValidName(firstName) && isValidName(lastName) && isValidEmail(email) else {
            errorMessageRelay.accept(Constant.validateMessage)
            return
        }
        errorMessageRelay.accept(nil)
        guard let firstName, let lastName, let email else { return }
        userServices.saveUser(data: UserServices.UserDataInput(
            firstName: firstName,
            lastName: lastName,
            email: email)
        )
        coordinator?.successLogIn()
    }
    

    
    func logInTapped() {
        coordinator?.showLogIn()
    }
}

extension SignInViewModel {
    private enum Constant {
        static let validateMessage = "Enter the correct data, please"
    }
}
