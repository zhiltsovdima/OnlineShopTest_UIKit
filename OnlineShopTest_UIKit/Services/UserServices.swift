//
//  UserServices.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 11.03.2023.
//

import UIKit
import CoreData

protocol UserServicesProtocol {
    var userLoggedIn: User? { get set }
    func setLoggedInUser(_ user: User)
    func updateImage(_ image: UIImage?)
    func saveUser(data: UserServices.UserDataInput) throws -> User
    func getUsers() -> [User]
}

final class UserServices: UserServicesProtocol {
    
    var userLoggedIn: User?

    private let coreDataManager: CoreDataManagerProtocol
    
    init(coreDataManager: CoreDataManagerProtocol) {
        self.coreDataManager = coreDataManager
    }
    
    func setLoggedInUser(_ user: User) {
        userLoggedIn = user
    }
    
    func updateImage(_ image: UIImage?) {
        let imageData = image?.jpegData(compressionQuality: 0.5)
        userLoggedIn?.setValue(imageData, forKey: "image")
        do {
            try coreDataManager.save()
        } catch {
            print("Failed saving to CoreData: \(error.localizedDescription)")
        }
    }
    
    func saveUser(data: UserDataInput) throws -> User {
        let user = User(context: coreDataManager.moc)
        user.setValue(data.firstName, forKey: "firstName")
        user.setValue(data.lastName, forKey: "lastName")
        user.setValue(data.email, forKey: "email")
        let imageData = data.image?.jpegData(compressionQuality: 0.5)
        user.setValue(imageData, forKey: "image")
        do {
            try coreDataManager.save()
            return user
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
        let image: UIImage?
    }
}
