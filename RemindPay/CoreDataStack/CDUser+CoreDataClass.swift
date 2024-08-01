//
//  CDUser+CoreDataClass.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 01/08/24.
//
//

import Foundation
import CoreData

@objc(CDUser)
public class CDUser: NSManagedObject {

    func convertToUser() -> User {
        let membershipType: MembershipType = membershipType.lowercased() == "free" ? .free: .paid(value: 0)
        let services = subscribedServices.compactMap { service in
            ServiceType(rawValue: service)
        }
        return .init(id: id, name: name, phone: phone, email: email, profileImageUrl: profileImageUrl, membership: membershipType, subscribedServices: services)
    }

}
