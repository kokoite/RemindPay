//
//  HomePresenter.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 01/08/24.
//

import Foundation
import UIKit


protocol HomePresentingLogic: AnyObject {
    func presentFetchUser(user: User)
}

final class HomePresenter: HomePresentingLogic {

    weak var viewController: HomeDisplayLogic?

    func presentFetchUser(user: User) {
        Task {
            do {
                let image = try getImageFrom(fileName: user.profileImageUrl)
                DispatchQueue.main.async { [weak self] in
                    guard let self, let image else { return }
                    self.viewController?.displayFetchUserHeader(using: .init(name: user.name, profileImage: image))
                }

            } catch (let error) {
                print("Error is \(error.localizedDescription)")
            }
        }
    }
}
