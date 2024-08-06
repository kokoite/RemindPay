//
//  TenantInteractor.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 03/08/24.
//

import Foundation


protocol RentBusinessLogic: AnyObject {

    func fetchAllTenants()
}

protocol RentDataStore {
    var users: [Tenant]? { get set }
}

final class RentInteractor: RentBusinessLogic, RentDataStore {

    weak var viewController: RentDisplayLogic?
    let worker = RentWorker.instance
    var response: [Tenant] = []
    var users: [Tenant]?



    func fetchAllTenants() {
        Task {
            do {
                let tenants = try await worker.fetchAllTenants()
                self.users = tenants
                let users: [Rent.Refresh.Response.ViewModel] = tenants.map { user in
                        .init(name: user.name, phone: user.phone, expiryDate: user.rentExpireDate, profileImage: user.profileImage)
                }
                DispatchQueue.main.async {
                    self.viewController?.displayFetchAllTenant(using: users)
                }
            } catch (let error) {
                print("Error \(error.localizedDescription)")
            }
        }
    }
}
