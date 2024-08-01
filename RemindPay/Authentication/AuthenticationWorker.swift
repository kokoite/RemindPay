//
//  LoginRepository.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 31/07/24.
//

import Foundation
import CoreData

final class AuthenticationWorker {

    private let context = CoreDataStack.instance.managedObjectContext

    func saveUserToCoreData(user: User) throws {
        Task {
            let cdUser = CDUser(context: context)
            let services = user.subscribedServices.compactMap { service in
                service.rawValue
            }
            cdUser.name = user.name
            cdUser.id = user.id
            cdUser.email = user.email
            cdUser.membershipType = "free"
            cdUser.phone = user.phone
            cdUser.profileImageUrl = user.profileImageUrl
            cdUser.subscribedServices = services
            do {
                try context.save()
            } catch(let error) {
                print("unable to save data to coreData")
                throw(error)
            }
        }
    }

    func fetchUserFromCoreData() throws {
        Task {
            do {
                let fetchRequest = CDUser.fetchRequest()
                let users = try context.fetch(fetchRequest)
                guard users.count == 1, let user = users.first else { throw NSError(domain: "", code: 2) }

                print(user.convertToUser())

            } catch(let error) {
                print("unable to fetch users \(error.localizedDescription)")
                throw(error)
            }
        }
    }
}
