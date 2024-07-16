//
//  GymModel.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//

enum GymModel {

    struct Request {

    }


    struct Response {

    }


    struct User {
        let name, email, phone, userId, address, gender: String
        let expiryTime, joiningTime: CLongLong
        let photos: [String]
        let payment, weight, height: [Int]
        let existingDisease: [String]
        let paymentStatus, isActive: Bool
    }

    struct UserSummary {
        let name, phone, joiningDate, expiryDate: String
    }
}
