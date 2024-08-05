//
//  CreateLibraryUserInteractor.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 05/08/24.
//

import Foundation


protocol CreateLibraryUserBusinessLogic: AnyObject {
    func createUser(using request: Library.Create.Request)
}

final class CreateLibraryUserInteractor: CreateLibraryUserBusinessLogic {
    private let worker = CreateLibraryUserWorker.instance
    weak var viewController: CreateLibraryUserDisplayLogic?
    var error: Error?

    func createUser(using request: Library.Create.Request) {
        Task {
            do {
                let req = request.user
                let user = Library.User(id: UUID(), name: req.name, phone: req.phone, age: req.age, address: req.address, profileImage: req.profileImage, planStart: req.planStart, planEnd: req.planEnd, amount: req.amount, joinedDate: req.planStart, lastPaymentDate: req.planStart, lastPaymentAmount: req.amount)

                try worker.createUser(using: user)

            } catch let error {
                self.error = error
                print("Error \(error.localizedDescription)")
            }

            handleResponse()
        }
    }

    private func handleResponse() {
        guard error == nil else {
            
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.viewController?.displayCreateLibraryUser(response: .init(state: .error(error: self.error!)))
            }
            return
        }

        DispatchQueue.main.async { [weak self] in
            self?.viewController?.displayCreateLibraryUser(response: .init(state: .success))
        }
    }
}
