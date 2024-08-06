//
//  TenantInteractor.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 05/08/24.
//

import Foundation


protocol TenantBusinessLogic: AnyObject {

    func fetchUser(using request: Rent.Fetch.Request)
}

protocol TenantDataStore {
    var tenant: Tenant? {get set}
}

final class TenantInteractor: TenantBusinessLogic, TenantDataStore {


    weak var presenter: TenantPresentingLogic?

    var tenant: Tenant?

    func fetchUser(using request: Rent.Fetch.Request) {
        
        guard let tenant else {
            presenter?.presentResponse(using: .init(tenant: nil, error: NSError(domain: "User not found", code: 10)))
            return
        }

        presenter?.presentResponse(using: .init(tenant: tenant, error: nil))
    }


}

