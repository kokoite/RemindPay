//
//  RentRouter.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 05/08/24.
//

import Foundation
import UIKit


protocol RentRoutingLogic: AnyObject {
    func routeToDetailPage(using index: Int)
}

protocol RentDataPassing: AnyObject {
    var dataStore: RentDataStore? {get set}
}

final class RentRouter: RentDataPassing, RentRoutingLogic {

    var dataStore: RentDataStore?
    weak var viewController: UIViewController?

    func routeToDetailPage(using index: Int) {
        guard let dataStore, let users = dataStore.users else { return }
        let controller = TenantDetailViewController()
        controller.router?.dataStore?.tenant = users[index]

        viewController?.navigationController?.pushViewController(controller, animated: true)
    }
}
