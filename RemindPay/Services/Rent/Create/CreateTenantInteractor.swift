//
//  CreateTenantInteractor.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 02/08/24.
//

import Foundation


protocol CreateTenantBusinessLogic: AnyObject {
    func createTenant(using tenant: Tenant)
}


final class CreateTenantInteractor: CreateTenantBusinessLogic {

    weak var viewController: CreateTenantDisplayLogic?
    let worker = CreateTenantWorker.instance

    func createTenant(using tenant: Tenant) {
        // can we save images to 
        Task {
            do {
                try worker.createTenant(tenant: tenant)
                DispatchQueue.main.async {[weak self] in
                    self?.viewController?.displayCreateTenant(response: .init(state: .success))
                }
            } catch (let error) {
                print("Error \(error.localizedDescription)")
                DispatchQueue.main.async {[weak self] in
                    self?.viewController?.displayCreateTenant(response: .init(state: .error(error: error)))
                }
            }
        }
    }
}
