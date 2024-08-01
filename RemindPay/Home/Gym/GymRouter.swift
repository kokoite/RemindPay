//
//  GymRouter.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//
import UIKit

protocol GymRoutingLogic: AnyObject {
    func routeToGymUserDetailPage()
    func routeToCreateUserPage()
    func routeToProfilePage()
    func showFilterBottomSheet()
    func showErrorBottomSheet()
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

    func routeToCreateUserPage() {
        guard let navController = viewController?.navigationController else { return }
        let controller = CreateGymUserViewController()
        navController.pushViewController(controller, animated: true)
    }

    func routeToProfilePage() {
        guard let navController = viewController?.navigationController else { return }
        let controller = GymProfileViewController()
        navController.pushViewController(controller, animated: true)
    }

    func showErrorBottomSheet() {
        guard let viewController else { return }
        let bottomSheetTransitioningDelegate = BottomSheetTransitionDelegate(of: .init(width: viewController.view.bounds.width, height: 300))
        let bottomSheetVC = ErrorBottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .custom
        bottomSheetVC.transitioningDelegate = bottomSheetTransitioningDelegate
        viewController.present(bottomSheetVC, animated: true)
    }

    func showFilterBottomSheet() {
        guard let viewController = viewController as? GymViewController else { return }
        let bottomSheetTransitioningDelegate = BottomSheetTransitionDelegate(of: .init(width: viewController.view.bounds.width, height: 350))
        let bottomSheetVC = FilterBottomSheetViewController()
        bottomSheetVC.delegate = viewController
        bottomSheetVC.modalPresentationStyle = .custom
        bottomSheetVC.transitioningDelegate = bottomSheetTransitioningDelegate
        viewController.present(bottomSheetVC, animated: true)
    }
}