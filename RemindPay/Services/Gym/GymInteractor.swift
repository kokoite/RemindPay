//
//  GymInteractor.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//


import Foundation

// MARK :- Gym Home page Business logic
protocol GymBusinessLogic: AnyObject {

    func fetchAllUsers(request: Gym.Refresh.Request)
}

protocol GymDataStore: AnyObject {

    var selectedIndex: Int? { get }
}

// MARK :- Create User Business Logic
protocol CreateGymUserBusinessLogic: AnyObject {

    func createUser(request: Gym.Create.Request)
}

protocol CreateGymUserDataStore: AnyObject {

}

// MARK :- User Detail Business Logic
protocol GymUserDetailBusinessLogic: AnyObject {

    func fetchUserDetails()
}

protocol GymUserDetailDataStore: AnyObject {

}



final class GymInteractor: GymDataStore, GymBusinessLogic {
    var presenter: GymPresenter?
    weak var viewController: GymDisplayLogic?
    weak var createViewController: CreateGymUserDisplayLogic?
    weak var gymUserDetailViewController: GymUserDetailDisplayLogic?
    var selectedIndex: Int?

    private let worker = GymWorker.instance
    private let createWorker = CreateGymUserWorker.instance

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

// MARK :- Create Gym User
extension GymInteractor: CreateGymUserBusinessLogic, CreateGymUserDataStore {
    func createUser(request: Gym.Create.Request) {
        Task {
            do {
                try createWorker.createUser(user: request.user)
                DispatchQueue.main.async {
                    self.createViewController?.displayCreateUser(response: .init(state: .success))
                }
            } catch let error {
                print("Error \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.createViewController?.displayCreateUser(response: .init(state: .error(error: error)))
                }
            }
        }
    }
}

extension GymInteractor: GymUserDetailBusinessLogic, GymUserDetailDataStore {

    func fetchUserDetails() {
        guard let selectedIndex else { 
            print("selected index is nil")
            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.gymUserDetailViewController?.displayFetchUserDetail()
        }
    }
}

