//
//  HomeInteractor.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 01/08/24.
//

import Foundation

protocol HomeBusinessLogic: AnyObject {
    func fetchUserDetails()
}

final class HomeInteractor: HomeBusinessLogic {
    private let worker = HomeWorker.instance

    weak var presenter: HomePresentingLogic?

    func fetchUserDetails() {
        Task {
            do {
                let user = try self.worker.fetchUser()
                if let name = user.name.split(separator: " ", maxSplits: 1).first {
                    let newUser = User(id: user.id, name: String(name), phone: user.phone, email: user.email, profileImageUrl: user.profileImageUrl, membership: user.membership, subscribedServices: user.subscribedServices)
                    self.presenter?.presentFetchUser(user: newUser)
                } else {
                    self.presenter?.presentFetchUser(user: user)
                }

            } catch (let error) {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
