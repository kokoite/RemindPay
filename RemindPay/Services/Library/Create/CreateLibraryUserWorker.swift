//
//  CreateLibraryUserWorker.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 05/08/24.
//

import Foundation

final class CreateLibraryUserWorker {
    private let utility = DateUtility.instance
    private let context = CoreDataStack.instance.managedObjectContext
    static let instance = CreateLibraryUserWorker()
    private init() { }

    func createUser(using user: Library.User) throws {
        let req = CDLibraryUser(context: context)
        req.id = user.id
        req.name = user.name
        req.phone = user.phone
        req.address = user.address
        req.age = Int32(user.age) ?? 0
        req.amount = Int32(user.amount) ?? 0
        req.joined = utility.convertStringToLong(date: user.planStart)
        req.planStart = utility.convertStringToLong(date: user.planStart)
        req.planEnd = utility.convertStringToLong(date: user.planEnd)
        req.lastPaymentDate = utility.convertStringToLong(date: user.planStart)
        req.lastPaymentAmount = Int32(user.amount) ?? 0
        req.profileImage = user.profileImage
        try context.save()
    }

}
