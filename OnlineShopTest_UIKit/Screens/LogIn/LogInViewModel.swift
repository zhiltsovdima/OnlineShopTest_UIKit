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
    
    private func isValid(_ field: String?) -> Bool {
        guard let field else { return false }
        return field.isEmpty ? false : true
    }
}

extension LogInViewModel: LogInViewModelProtocol {
    
    func logInTapped(name: String?, password: String?) {
        guard isValid(name) && isValid(password) else {
            errorMessageRelay.accept(Constant.emptyMessage)
            return
        }
        let user = userServices.getUsers()
            .first(where: { $0.firstName == name })
        print(user ?? "empty")
        guard user != nil else {
            errorMessageRelay.accept(Constant.incorrectMessage)
            return
        }
        coordinator?.successLogIn()
    }
    
}

extension LogInViewModel {
    private enum Constant {
        static let emptyMessage = "Enter the data, please"
        static let incorrectMessage = "This user doesnt't exist"
    }
}
