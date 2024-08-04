//
//  TenantWorker.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 03/08/24.
//

import Foundation


final class RentWorker {

    private let context = CoreDataStack.instance.managedObjectContext
    static let instance = RentWorker()
    private init() { }

    // TODO :- Implement pagination
    func fetchAllTenants() async throws -> [Tenant] {

        let fetchRequest = CDTenant.fetchRequest()
        let tenants = try context.fetch(fetchRequest)
        let users = tenants.map { user in
            user.convertToTenant()
        }
        return users
    }
}
