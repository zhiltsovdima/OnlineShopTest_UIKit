//
//  UserServices.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 11.03.2023.
//

import Foundation
import CoreData

protocol UserServicesProtocol {
    func saveUser(data: UserServices.UserDataInput) throws
    func getUsers() -> [User]
}

final class UserServices: UserServicesProtocol {
        
    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    func saveUser(data: UserDataInput) throws {
        let user = User(context: coreDataManager.moc)
        user.setValue(data.firstName, forKey: "firstName")
        user.setValue(data.lastName, forKey: "lastName")
        user.setValue(data.email, forKey: "email")
        do {
            try coreDataManager.save()
        } catch {
            print("Failed saving to CoreData: \(error.localizedDescription)")
            throw UserAuthError.savingNewUserError
        }
    }
    
    func getUsers() -> [User] {
        return coreDataManager.getAll()
    }
}

extension UserServices {
    
    struct UserDataInput {
        let firstName: String
        let lastName: String
        let email: String
    }
}
