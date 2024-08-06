//
//  TenantRouter.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 05/08/24.
//

import Foundation

protocol TenantRoutingLogic: AnyObject {

    func routeToRentPage()
}

protocol TenantDataPassing: AnyObject {
    var dataStore: TenantDataStore? { get set }
}


final class TenantRouter: TenantRoutingLogic, TenantDataPassing {

    var dataStore: TenantDataStore?

    func routeToRentPage() {

    }

}
