//
//  CoreData.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 28/07/24.
//

import Foundation

import CoreData

final class CoreDataStack {

    static let instance = CoreDataStack()
    
    private init() {
        print("core data instance initialized")
    }

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RemindPay")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var managedObjectContext = {
        return persistentContainer.viewContext
    }()

    func saveContext () {

        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


    deinit {
        print("core data instance deinitialized")
    }
}
