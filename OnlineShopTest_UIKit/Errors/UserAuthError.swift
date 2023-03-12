//
//  UserAuthError.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 12.03.2023.
//

import Foundation

enum UserAuthError: Error {
    case emptyData
    case userAlreadyExist
    case userDoesntExist
    case savingNewUserError
    case firstNameEmpty
    case lastNameEmpty
    case incorrectEmail
    
    var description: String {
        switch self {
        case .emptyData:
            return "Enter the data please."
        case .userAlreadyExist:
            return "This user already exist. Plese log in."
        case .userDoesntExist:
            return "User doesn't exist."
        case .savingNewUserError:
            return "Something went wrong."
        case .firstNameEmpty:
            return "Enter your First Name."
        case .lastNameEmpty:
            return "Enter your Last Name."
        case .incorrectEmail:
            return "Enter the correct email."
        }
    }
}
