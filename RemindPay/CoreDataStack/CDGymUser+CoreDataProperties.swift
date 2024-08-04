//
//  CDGymUser+CoreDataProperties.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 04/08/24.
//
//

import Foundation
import CoreData


extension CDGymUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGymUser> {
        return NSFetchRequest<CDGymUser>(entityName: "CDGymUser")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var age: Int32
    @NSManaged public var weight: [String]
    @NSManaged public var height: [String]
    @NSManaged public var profileImage: [String]
    @NSManaged public var phone: String
    @NSManaged public var address: String
    @NSManaged public var disease: String
    @NSManaged public var payment: Int32
    @NSManaged public var planStart: Int64
    @NSManaged public var planEnd: Int64
    @NSManaged public var joined: Int64
    @NSManaged public var lastPaymentDate: Int64
    @NSManaged public var lastPaymentAmount: Int32

}

extension CDGymUser : Identifiable {

}
