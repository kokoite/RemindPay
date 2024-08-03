//
//  CDTenant+CoreDataProperties.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 03/08/24.
//
//

import Foundation
import CoreData


extension CDTenant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDTenant> {
        return NSFetchRequest<CDTenant>(entityName: "CDTenant")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var joinedDate: Int64
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var profileImage: String?
    @NSManaged public var propertyImages: [String]?
    @NSManaged public var rentEndDate: Int64
    @NSManaged public var rentStartDate: Int64
    @NSManaged public var address: String?
    @NSManaged public var agreementStartDate: Int64
    @NSManaged public var agreementEndDate: Int64
    @NSManaged public var rent: Int32
    @NSManaged public var utility: Int32
    @NSManaged public var advance: Int32
    @NSManaged public var security: Int32

}

extension CDTenant : Identifiable {

}
