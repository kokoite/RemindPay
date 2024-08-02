//
//  HomeInteractor.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 01/08/24.
//

import Foundation

protocol HomeBusinessLogic: AnyObject {
    func fetchUserDetails()
    func subscribeToService(service: ServiceType)
}

final class HomeInteractor: HomeBusinessLogic {
    private let worker = HomeWorker.instance
    private var response: User? = nil

    weak var presenter: HomePresentingLogic?

    func fetchUserDetails() {
        Task {
            do {
                let user = try self.worker.fetchUser()
                response = user
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

    func subscribeToService(service: ServiceType) {
        guard let response else { return }
        Task {
            do {
                let user = try worker.updateUserSubscribedServices(id: response.id, serviceType: service)
                try worker.updateUserInUserDefaults(user: user)
                self.response = user
            } catch (let error) {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
