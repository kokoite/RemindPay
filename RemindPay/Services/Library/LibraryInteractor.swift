//
//  LibraryInteractor.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 05/08/24.
//

import Foundation


protocol LibraryBusinessLogic: AnyObject {

    func fetchAllUsers(request: Library.Refresh.Request)
}

final class LibraryInteractor: LibraryBusinessLogic {

    weak var presenter: LibraryViewPresentingLogic?
    private let worker = LibraryWorker.instance
    private var response: Library.Refresh.Response?
    private var data: [Library.User] = []
    private var error: Error?

    func fetchAllUsers(request: Library.Refresh.Request) {
        Task {
            do {
                self.data = try worker.fetchAllUsers()

            } catch let error {
                print("Error \(error.localizedDescription)")
                self.error = error
            }
            handleResponse()
        }
    }

    private func handleResponse() {
        guard error == nil else {
            presenter?.presentResponse(using: .init(error: error, users: []))
            return
        }
        presenter?.presentResponse(using: .init(error: nil, users: data))
    }
}
