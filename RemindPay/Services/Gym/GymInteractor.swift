//
//  GymInteractor.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//

protocol GymBusinessLogic: AnyObject {

}

protocol GymDataStore: AnyObject {

}

final class GymInteractor: GymDataStore, GymBusinessLogic {
    var presenter: GymPresenter?
}
