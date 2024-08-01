//
//  CreateGymUserInteractor.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 31/07/24.
//

import Foundation

protocol CreateGymUserBusinessLogic: AnyObject {

    func createUser()
}

protocol CreateGymUserDataStore: AnyObject {
    var owner: UUID? { get }
}

final class CreateGymUserInteractor: CreateGymUserDataStore, CreateGymUserBusinessLogic {

    var owner: UUID? = nil

    func createUser() {
        // create user
    }
}
