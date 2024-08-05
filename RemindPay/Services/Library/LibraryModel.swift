//
//  LibraryModel.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 05/08/24.
//

import Foundation
import UIKit


enum Library {

    enum Refresh {
        struct Request {

        }

        struct Response {
            let error: Error?
            let users: [User]
        }

        struct ViewModel {
            
            let state: State

            enum State {
                case success(users: [User])
                case error(error: Error)
            }

            struct User {
                let name, phone, expiryDate: String
                let profileImage: UIImage?
            }
        }
    }

    enum Create {
        
        struct Request {
            let user: User
        }

        struct User {
            let name, phone, age, address, profileImage, planStart, planEnd, amount: String
        }

        struct Response {

        }

        struct ViewModel {
            let state: State
        }

        enum State {
            case success
            case error(error: Error)
        }
    }

    enum Fetch {

    }

    enum Update {

    }

    struct User {
        let id: UUID
        let name, phone, age, address, profileImage, planStart, planEnd, amount, joinedDate, lastPaymentDate, lastPaymentAmount: String
    }
}
