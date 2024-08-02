//
//  HomeWorker.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 01/08/24.
//

import Foundation


final class HomeWorker {

    static let instance = HomeWorker()
    private let context = CoreDataStack.instance.managedObjectContext
    private init() { }

    func fetchUser() throws -> User {
        do {
            let user = try self.fetchUserFromUserDefaults()
            return user
        } catch (let error) {
            print("Unable to fetch user")
            throw error
        }
    }

    func fetchUserById(id: UUID) throws -> CDUser {
        let fetchRequest = CDUser.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id ==%@", id as CVarArg)
        guard let user = try context.fetch(fetchRequest).first else {
            throw NSError(domain: "User not found", code: 10)
        }
        return user
    }

    func updateUserSubscribedServices(id: UUID, serviceType: ServiceType) throws -> User {
        let user = try fetchUserById(id: id)
        // what if user is already subscribed to 
        let alreadySubscribed = user.subscribedServices.contains { service in
            service == serviceType.rawValue
        }
        guard !alreadySubscribed else {
            throw NSError(domain: "Already subscribed", code: 10)
        }
        user.subscribedServices.append(serviceType.rawValue)
        try context.save()
        return user.convertToUser()
    }

    func updateUserInUserDefaults(user: User) throws {
        let encoder = JSONEncoder()
        do {
            let encodedUser = try encoder.encode(user)
            UserDefaults.standard.set(encodedUser, forKey: "user")

        } catch (let error) {
            print(error.localizedDescription)
            throw error
        }
    }

    private func fetchUserFromUserDefaults() throws -> User {
        guard let data = UserDefaults.standard.data(forKey: "user") else {
            throw NSError(domain: "User not found in user defaults", code: 10)
        }

        let decoder = JSONDecoder()
        do {
            let user = try decoder.decode(User.self, from: data)
            return user
        } catch (let error) {
            print("Error occured while decoding")
            throw(error)
        }
    }
}
