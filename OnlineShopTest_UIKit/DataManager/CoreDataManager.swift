//
//  CoreDataManager.swift
//  OnlineShopTest_UIKit
//
//  Created by Dima Zhiltsov on 10.03.2023.
//

import Foundation
import CoreData

protocol CoreDataManagerProtocol {
    var moc: NSManagedObjectContext { get }
    func save()
    func getAll<T: NSManagedObject>() -> [T]
}

final class CoreDataManager: CoreDataManagerProtocol {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "OnlineShopTest_UIKit")
        persistentContainer.loadPersistentStores { _, error in
            guard let error else { return }
            print("Failed to load PersistentStores: \(error.localizedDescription)")
        }
        return persistentContainer
    }()
    
    var moc: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    func save() {
        do {
            try moc.save()
        } catch {
            print("Failed saving moc: \(error.localizedDescription)")
        }
    }
    
    func getAll<T: NSManagedObject>() -> [T] {
        do {
            let fetchRequest = NSFetchRequest<T>(entityName: "\(T.self)")
            return try moc.fetch(fetchRequest)
        } catch {
            print("Fetching failed: \(error.localizedDescription)")
            return []
        }
    }
}
