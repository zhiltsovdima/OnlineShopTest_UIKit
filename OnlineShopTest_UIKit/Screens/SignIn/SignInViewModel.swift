//
//  SignInViewModel.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 10.03.2023.
//

import Foundation

protocol SignInViewModelProtocol: AnyObject {
    
}

final class SignInViewModel {
    
    private weak var coordinator: AuthCoordinatorProtocol?
    
    init(coordinator: AuthCoordinatorProtocol? = nil) {
        self.coordinator = coordinator
    }
}

extension SignInViewModel: SignInViewModelProtocol {
    
}
