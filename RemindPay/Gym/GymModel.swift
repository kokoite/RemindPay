//
//  GymModel.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//

enum GymModel {

    enum Refresh {
        struct Request {

        }

        struct ViewModel {

            let header: Header
            let users: [User]

            struct Header {
                let name: String
                let profileUrl: String
            }

            struct User {
                let name, joiningTime, expiryTime, profileUrl, phone: String
                let isActive: Bool
            }
        }
    }

    struct Request: Encodable {
        let id: String
    }

    struct Response: Decodable {
        let owner: Owner
        let users: [User]

        struct Owner: Decodable {
            let name, profileUrl, ownerId: String
        }

        struct User: Decodable {
            let name, userId, phone, profileUrl, joiningDate, expiryDate, existingDisease, address: String
            let payment: Int
            let profileCreated: String
            let isActive, paymentStatus: Bool
            // In order to make graph for weight and height
            let weight, height: [Int]
        }
    }
}
