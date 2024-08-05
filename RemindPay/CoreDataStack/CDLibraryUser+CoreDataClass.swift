//
//  CDLibraryUser+CoreDataClass.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 05/08/24.
//
//

import Foundation
import CoreData

@objc(CDLibraryUser)
public class CDLibraryUser: NSManagedObject {


    func convertToLibraryUser() -> Library.User {
        let utility = DateUtility.instance
        let age = String(age)
        let amonut = String(amount)
        let lastAmount = String(lastPaymentAmount)
        let startDate = utility.convertLongToString(date: planStart)
        let endDate = utility.convertLongToString(date: planEnd)
        let joined = utility.convertLongToString(date: joined)
        let lastPaymentDate = utility.convertLongToString(date: lastPaymentDate)
        

        return .init(id: id, name: name, phone: phone, age: age, address: address, profileImage: profileImage, planStart: startDate, planEnd: endDate, amount: amonut, joinedDate: joined, lastPaymentDate: lastPaymentDate, lastPaymentAmount: lastAmount)
    }
}
