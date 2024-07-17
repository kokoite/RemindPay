//
//  ErrorViewModel.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 17/07/24.
//

struct ErrorAction {
    let title: String
    let handle: (() -> Void)?
}

struct ErrorViewModel {
    var actions: [ErrorAction]
    var dataModel: ErrorModel
    var performAction: (() -> Void)?
}
