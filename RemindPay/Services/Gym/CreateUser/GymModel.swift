//
//  GymModel.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 03/08/24.
//

import Foundation

enum Gym {

    enum Refresh {
        
        struct Request {

        }

        struct Response {
            let state: State
        }

        struct ViewModel {
            let users: [User]
        }

        struct User {
            let name, phone, expiryDate, profileImage: String
        }

        enum State {
            case success(viewModel: ViewModel)
            case error(error: Error)
        }
    }

    enum Create {

        struct Request {
            let user: User
        }

        struct Response {
            let state: State
        }
    }

    enum State {
        case success
        case error(error: Error)
    }

    struct User {
        let id: UUID
        let name, phone, address,
            disease, planStarting,
            planEnding, joinedDate,
            lastPaymentDate, lastPaymentAmount, age, planAmount
        : String

        let weight, height, profileImage: [String]
    }
}

