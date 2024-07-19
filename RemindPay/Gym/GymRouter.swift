//
//  GymRouter.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//
import UIKit

protocol GymRoutingLogic: AnyObject {
    func routeToGymUserDetailPage()
}

protocol GymDataPassing: AnyObject {
    var dataStore: GymDataStore? { get }
}

final class GymRouter: GymRoutingLogic, GymDataPassing {

    var viewController: UIViewController?
    var dataStore: GymDataStore?


    func routeToGymUserDetailPage() {
        guard let navController = viewController?.navigationController else { return }
        let controller = UserDetailViewController()
        navController.pushViewController(controller, animated: true)
    }

}
