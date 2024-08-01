//
//  HomeWorker.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 01/08/24.
//

import Foundation


final class HomeWorker {

    static let instance = HomeWorker()
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

    private func fetchUserFromCoreData() {
        
    }
}
