//
//  CDUser+CoreDataClass.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 31/07/24.
//
//

import Foundation
import CoreData

@objc(CDUser)
public class CDUser: NSManagedObject {


    func convertToUser() -> User {
        let membershipType: MembershipType = membershipType.lowercased() == "free" ? .free: .paid(value: 0)
        return .init(id: id, name: name, phone: phone, email: email, profileImageUrl: profileImageUrl, membership: membershipType)
    }
}
