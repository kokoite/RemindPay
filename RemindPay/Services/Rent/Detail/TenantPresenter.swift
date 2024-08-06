//
//  TenantPresenter.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 05/08/24.
//

import UIKit

protocol TenantPresentingLogic: AnyObject {

    func presentResponse(using response: Rent.Fetch.Response)
}

final class TenantPresenter: TenantPresentingLogic {

    weak var viewController: TenantDisplayLogic?

    func presentResponse(using response: Rent.Fetch.Response) {

        guard let user = response.tenant, response.error == nil else {
            self.handleError(using: response.error!)
            return
        }
        
        Task {
            do {

                let manager = ImageManager.instance
                let images = try await withThrowingTaskGroup(of: UIImage?.self) { group in
                    var result: [UIImage?] = []
                    for name in user.propertyImages {
                        group.addTask {
                            let image = try manager.fetchImage(using: name)
                            return image
                        }
                    }

                    for try await image in group {
                        result.append(image)
                    }
                    return result
                }
                
                let image = try manager.fetchImage(using: user.profileImage)

                let user: Rent.Fetch.ViewModel.User = .init(name: user.name, phone: user.phone, address: user.address, profileImage: image, agreementStartDate: user.agreementStartDate, agreementEndDate: user.agreementEndDate, rentStartDate: user.rentStartDate, rentExpireDate: user.rentExpireDate, joinedDate: user.joinedDate, advanceAmount: user.advanceAmount, securityAmount: user.securityAmount, rentAmount: user.rentAmount, utilityAmount: user.utilityAmount, propertyImages: images)
                self.handleSuccess(using: user)
            } catch let error {
                self.handleError(using: error)

            }
        }

    }

    private func handleSuccess(using user: Rent.Fetch.ViewModel.User) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.viewController?.displayFetchUser(using: .init(state: .success(user: user)))
        }
    }

    private func handleError(using error: Error) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.viewController?.displayFetchUser(using: .init(state: .error(error: error)))
        }
    }

}
