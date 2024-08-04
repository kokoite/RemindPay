//
//  GymUserDetailPresenter.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 04/08/24.
//

import UIKit
import Foundation


protocol GymUserDetailPresentingLogic: AnyObject {

    func presentUserDetailResponse(using response: Gym.Fetch.Response)
}

final class GymUserDetailPresenter: GymUserDetailPresentingLogic {

    private let manager = ImageManager.instance

    weak var viewController: GymUserDetailDisplayLogic?

    func presentUserDetailResponse(using response: Gym.Fetch.Response) {
        guard let user = response.user, response.error == nil else {
            DispatchQueue.main.async {
                self.viewController?.displayFetchUserDetail(using: .init(state: .error(error: response.error!)))
            }
            return
        }

        Task {
            do {
                let images = try await withThrowingTaskGroup(of: UIImage?.self) { group in
                    var results: [UIImage?] = []
                    for image in user.profileImage {
                        group.addTask {
                            let img = try self.manager.fetchImage(using: image)
                            return img
                        }
                    }
                    do {
                        for try await image in group {
                            results.append(image)
                        }
                        return results
                    } catch let error {
                        print("error \(error.localizedDescription)")
                        throw error
                    }
                }
                let userImages = images.compactMap { $0 }
                let obj: Gym.Fetch.User = .init(name: user.name, phone: user.phone,
                                                address: user.address, disease: user.disease,
                                                planStarting: user.planStarting, planEnding: user.planEnding,
                                                joinedDate: user.joinedDate, lastPaymentDate: user.lastPaymentDate,
                                                lastPaymentAmount: user.lastPaymentAmount, age: user.age,
                                                planAmount: user.planAmount, weight: user.weight,
                                                height: user.height, profileImage: userImages)
                DispatchQueue.main.async { [weak self] in
                    self?.viewController?.displayFetchUserDetail(using: .init(state: .success(user: obj)))
                }


            } catch let error {
                DispatchQueue.main.async { [weak self] in
                    self?.viewController?.displayFetchUserDetail(using: .init(state: .error(error: error)))
                }
            }
        }
    }
}
