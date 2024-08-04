//
//  GymUserDetailRouter.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 04/08/24.
//

import Foundation

protocol GymUserDetailRoutingLogic: AnyObject {

    func routeToEditScreen()
}

protocol GymUserDetailDataPassing: AnyObject {
    var dataStore: GymUserDetailDataStore? {get set}
}


final class  GymUserDetailRouter: GymUserDetailDataPassing, GymUserDetailRoutingLogic {

    var dataStore: GymUserDetailDataStore?

    func routeToEditScreen() {
        print("Route to edit screen")
    }


}
