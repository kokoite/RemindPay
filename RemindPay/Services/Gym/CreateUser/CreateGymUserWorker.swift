//
//  CreateGymUserWorker.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 03/08/24.
//

import Foundation


final class CreateGymUserWorker {

    private let context = CoreDataStack.instance.managedObjectContext
    static let instance = CreateGymUserWorker()
    private let utility = DateUtility.instance
    private init() { }

    func createUser(user: Gym.User) throws {
        let obj = CDGymUser(context: context)
        obj.id = user.id
        obj.name = user.name
        obj.phone = user.phone
        obj.address = user.address
        obj.disease = user.disease
        obj.age = Int32(user.age) ?? 0
        obj.height = user.height
        obj.weight = user.weight
        obj.lastPaymentAmount = Int32(user.lastPaymentAmount) ?? 0
        obj.lastPaymentDate = utility.convertStringToLong(date: user.lastPaymentDate)
        obj.payment = Int32(user.planAmount) ?? 0
        obj.profileImage = user.profileImage
        obj.planStart = utility.convertStringToLong(date: user.planStarting)
        obj.planEnd = utility.convertStringToLong(date: user.planEnding)
        obj.joined = utility.convertStringToLong(date: user.joinedDate)
        try context.save()
    }
}
