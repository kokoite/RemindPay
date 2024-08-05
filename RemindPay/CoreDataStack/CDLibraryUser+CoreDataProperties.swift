//
//  CDLibraryUser+CoreDataProperties.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 05/08/24.
//
//

import Foundation
import CoreData


extension CDLibraryUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDLibraryUser> {
        return NSFetchRequest<CDLibraryUser>(entityName: "CDLibraryUser")
    }

    @NSManaged public var name: String
    @NSManaged public var phone: String
    @NSManaged public var address: String
    @NSManaged public var amount: Int32
    @NSManaged public var planStart: Int64
    @NSManaged public var planEnd: Int64
    @NSManaged public var joined: Int64
    @NSManaged public var profileImage: String
    @NSManaged public var lastPaymentDate: Int64
    @NSManaged public var lastPaymentAmount: Int32
    @NSManaged public var id: UUID
    @NSManaged public var age: Int32

}

extension CDLibraryUser : Identifiable {

}
