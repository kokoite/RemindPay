//
//  GymUserDetailInteractor.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 04/08/24.
//

import Foundation


// MARK :- User Detail Business Logic
protocol GymUserDetailBusinessLogic: AnyObject {

    func fetchUserDetails()
}

protocol GymUserDetailDataStore: AnyObject {

    var user: Gym.User? { get set }
}


final class GymUserDetailInteractor: GymUserDetailDataStore, GymUserDetailBusinessLogic {

    weak var presenter: GymUserDetailPresentingLogic?

    var user: Gym.User?

    func fetchUserDetails() {
        guard let user else { return }
        presenter?.presentUserDetailResponse(using: .init(user: user, error: nil))
    }
}
