//
//  Owner.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 31/07/24.
//
import Foundation

enum Owner {

    struct Create {
        let id = UUID()
        let name, phone, address: String
        let profileImage: Data
        let subscribedServices: [ServiceType]
    }


    struct Update {
        let name, phone, address: String?
        let profileImage: Data?
        let subscribedServices: [ServiceType]
    }
}
