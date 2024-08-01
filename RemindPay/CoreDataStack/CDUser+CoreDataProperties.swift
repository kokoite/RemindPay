//
//  CDUser+CoreDataProperties.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 31/07/24.
//
//

import Foundation
import CoreData


extension CDUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDUser> {
        return NSFetchRequest<CDUser>(entityName: "CDUser")
    }

    @NSManaged public var name: String
    @NSManaged public var phone: String
    @NSManaged public var email: String
    @NSManaged public var profileImageUrl: String
    @NSManaged public var membershipType: String
    @NSManaged public var id: UUID

}

extension CDUser : Identifiable {

}
