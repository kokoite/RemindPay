//
//  CreateGymUserInteractor.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 31/07/24.
//

import Foundation

protocol CreateGymUserBusinessLogic: AnyObject {

    func createUser(request: Gym.Create.Request)
}

protocol CreateGymUserDataStore: AnyObject {

}

final class CreateGymUserInteractor: CreateGymUserDataStore, CreateGymUserBusinessLogic {

    weak var viewController: CreateGymUserDisplayLogic?
    let worker = CreateGymUserWorker.instance

    func createUser(request: Gym.Create.Request) {
        Task {
            do {
                
                try worker.createUser(user: request.user)
                DispatchQueue.main.async {
                    self.viewController?.displayCreateUser(response: .init(state: .success))
                }
            } catch let error {
                print("Error \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.viewController?.displayCreateUser(response: .init(state: .error(error: error)))
                }
            }
        }
    }
}
