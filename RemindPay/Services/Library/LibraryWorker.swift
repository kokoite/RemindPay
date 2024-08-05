//
//  LibraryWorker.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 05/08/24.
//

import Foundation


final class LibraryWorker {

    static let instance = LibraryWorker()
    private let utility = DateUtility.instance
    private let context = CoreDataStack.instance.managedObjectContext

    private init() { }

    func fetchAllUsers() throws -> [Library.User] {
        let fetchRequest = CDLibraryUser.fetchRequest()
        let users = try context.fetch(fetchRequest)
        let response = users.compactMap { user in
            user.convertToLibraryUser()
        }
        return response
    }
}
