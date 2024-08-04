//
//  CDGymUser+CoreDataClass.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 04/08/24.
//
//

import Foundation
import CoreData

@objc(CDGymUser)
public class CDGymUser: NSManagedObject {

    private let utillity = DateUtility.instance

    func convertToUser() -> Gym.User {

        let planStart = utillity.convertLongToString(date: planStart)
        let planEnd = utillity.convertLongToString(date: planEnd)
        let joined = utillity.convertLongToString(date: joined)
        let lastPaymentDate = utillity.convertLongToString(date: lastPaymentDate)
        let lastPayment = String(lastPaymentAmount)
        let age = String(age)
        let amount = String(payment)


        return .init(id: id, name: name, phone: phone, address: address, disease: disease, planStarting: planStart, planEnding: planEnd, joinedDate: joined, lastPaymentDate: lastPaymentDate, lastPaymentAmount: lastPayment, age: age, planAmount: amount, weight: weight, height: height, profileImage: profileImage)
    }
}
