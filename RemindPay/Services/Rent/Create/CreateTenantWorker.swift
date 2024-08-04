//
//  CreateTenantWorker.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 02/08/24.
//

import Foundation

final class CreateTenantWorker {
    static let instance = CreateTenantWorker()
    let context = CoreDataStack.instance.managedObjectContext
    let utility = DateUtility.instance

    private init() { }

    func createTenant(tenant: Tenant) throws {

        let user = CDTenant(context: context)
        user.id = tenant.id
        user.name = tenant.name
        user.address = tenant.address
        user.phone = tenant.phone
        user.profileImage = tenant.profileImage
        user.propertyImages = tenant.propertyImages
        user.advance = Int32(Int(tenant.advanceAmount) ?? 0)
        user.security = Int32(Int(tenant.securityAmount) ?? 0)
        user.utility = Int32(Int(tenant.utilityAmount) ?? 0)
        user.rent = Int32(Int(tenant.rentAmount) ?? 0)
        user.agreementEndDate = utility.convertStringToLong(date: tenant.agreementEndDate)
        user.agreementStartDate = utility.convertStringToLong(date: tenant.agreementStartDate)
        user.rentStartDate = utility.convertStringToLong(date: tenant.rentStartDate)
        user.rentEndDate = utility.convertStringToLong(date: tenant.rentExpireDate)
        do {
            try context.save()
        } catch (let error) {
            print("Error \(error.localizedDescription)")
            throw error
        }
    }
}



