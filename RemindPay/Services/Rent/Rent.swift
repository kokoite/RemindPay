//
//  TenantModel.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 03/08/24.
//

import Foundation


enum Rent {

    enum Create {

        struct Request {

        }

        struct Response {
            let state: State
        }

        enum State {
            case success
            case error(error: Error)
        }
    }


    enum Refresh {

        struct Request {

        }

        struct Response {

            let tenants: [ViewModel]
            
            struct ViewModel {
                let name, phone, expiryDate, profileImage: String
            }
        }
    }
}

struct Tenant {
    let id: UUID
    let name, phone, address: String
    let profileImage: String
    let agreementStartDate, agreementEndDate, rentStartDate, rentExpireDate, joinedDate: String
    let advanceAmount, securityAmount, rentAmount, utilityAmount: String
    let propertyImages: [String]
}
