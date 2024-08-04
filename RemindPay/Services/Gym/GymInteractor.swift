//
//  GymInteractor.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//


import Foundation

protocol GymBusinessLogic: AnyObject {

    func fetchAllUsers(request: Gym.Refresh.Request)
}

protocol GymDataStore: AnyObject {

}

final class GymInteractor: GymDataStore, GymBusinessLogic {
    var presenter: GymPresenter?
    weak var viewController: GymDisplayLogic?
    private let worker = GymWorker.instance

    func fetchAllUsers(request: Gym.Refresh.Request) {
        Task {
            do {
                let users = try worker.fetchAllUsers()
                let response: [Gym.Refresh.User] = users.map { user in
                        .init(name: user.name, phone: user.phone, expiryDate: user.planEnding, profileImage: user.profileImage[0])
                }
                DispatchQueue.main.async {
                    self.viewController?.displayRefresh(respnose: .init(state: .success(viewModel: .init(users: response))))
                }
            } catch let error {
                print("Error \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.viewController?.displayRefresh(respnose: .init(state: .error(error: error)))
                }
            }
        }
    }
}
