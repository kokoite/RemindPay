//
//  GymWorker.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//

final class GymWorker {
    static let instance = GymWorker()
    private let context = CoreDataStack.instance.managedObjectContext

    private init() { }


    // TODO :- Implement pagination
    func fetchAllUsers() throws -> [Gym.User] {
        let fetchRequest = CDGymUser.fetchRequest()
        let users = try context.fetch(fetchRequest)
        let response = users.map { user in
            user.convertToUser()
        }
        return response
    }

}
