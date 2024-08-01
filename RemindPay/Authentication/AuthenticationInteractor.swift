//
//  AuthenticationInteractor.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 31/07/24.
//

import Foundation

protocol AuthenticationBusinessLogic: AnyObject {
    func createUser(user: User)

}

final class AuthenticationInteractor: AuthenticationBusinessLogic {

    var coreData = CoreDataStack.instance
    let worker = AuthenticationWorker()
    weak var viewController: AuthenticationDisplayLogic?

    func createUser(user: User) {
        guard validateUser(user: user) else {
            viewController?.displayCreateUser(response: .init(state: .error(error: NSError(domain: "Something went wrong", code: 404))))
            return
        }
        Task {
            do {
                try worker.saveUserToCoreData(user: user)
                try saveUserToUserDefaults(user: user)
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.viewController?.displayCreateUser(response: .init(state: .success))
                }
            } catch (let error) {
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    print(error.localizedDescription)
                    self.viewController?.displayCreateUser(response: .init(state: .error(error: error)))
                }
            }
        }
    }


    private func validateUser(user: User) -> Bool {
        guard user.name.count > 2, user.email.count > 10, user.phone.count == 10, !user.profileImageUrl.isEmpty else {
            return false
        }
        return true
    }

    private func saveUserToUserDefaults(user: User) throws {
        let encoder = JSONEncoder()
        do {
            let encodedUser = try encoder.encode(user)
            UserDefaults.standard.set(encodedUser, forKey: "user")

        } catch (let error) {
            print(error.localizedDescription)
            throw error
        }
    }
}
