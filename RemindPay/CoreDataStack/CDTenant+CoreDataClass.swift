//
//  CDTenant+CoreDataClass.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 03/08/24.
//
//

import Foundation
import CoreData

@objc(CDTenant)
public class CDTenant: NSManagedObject {

    private let dateManager = DateUtility.instance
    func convertToTenant() -> Tenant {
        let aStart = dateManager.convertLongToString(date: agreementStartDate)
        let aEnd = dateManager.convertLongToString(date: agreementEndDate)
        let rStart = dateManager.convertLongToString(date: rentStartDate)
        let rEnd = dateManager.convertLongToString(date: rentEndDate)
        let jDate = dateManager.convertLongToString(date: joinedDate)
        let adv = String(advance)
        let util = String(utility)
        let sec = String(security)
        let rnt = String(rent)
        return .init(id: id, name: name, phone: phone, address: address, profileImage: profileImage, agreementStartDate: aStart, agreementEndDate: aEnd, rentStartDate: rStart, rentExpireDate: rEnd, joinedDate: jDate, advanceAmount: adv, securityAmount: sec, rentAmount: rnt, utilityAmount: util, propertyImages: propertyImages)
    }
}
