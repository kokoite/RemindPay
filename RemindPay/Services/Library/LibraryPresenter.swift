//
//  LibraryPresenter.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 05/08/24.
//

import Foundation
import UIKit


protocol LibraryViewPresentingLogic: AnyObject {

    func presentResponse(using response: Library.Refresh.Response)
}

final class LibraryPresenter: LibraryViewPresentingLogic {

    weak var viewController: LibraryViewDisplayLogic?
    private let manager = ImageManager.instance


    func presentResponse(using response: Library.Refresh.Response) {
        guard response.error == nil else {
            DispatchQueue.main.async {[weak self] in
                guard let self else { return }
                self.viewController?.displayRefreshAllUsers(using: .init(state: .error(error: response.error!)))
            }
            return
        }
        Task {
            let users = response.users
            do {
                let response = try await withThrowingTaskGroup(of: Library.Refresh.ViewModel.User.self) { group in
                    var results: [Library.Refresh.ViewModel.User] = []
                    for user in users {
                        group.addTask {
                            let image = try self.manager.fetchImage(using: user.profileImage)

                            return .init(name: user.name, phone: user.phone, expiryDate: user.planEnd, profileImage: image)
                        }
                    }
                    for try await user in group {
                        results.append(user)
                    }
                    return results
                }

                DispatchQueue.main.async {
                    self.viewController?.displayRefreshAllUsers(using: .init(state: .success(users: response)))
                }

            } catch let error {
                print("Error \(error.localizedDescription)")
                self.viewController?.displayRefreshAllUsers(using: .init(state: .error(error: error)))
                return
            }
        }
    }
}
