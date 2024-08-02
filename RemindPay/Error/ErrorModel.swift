//
//  ErrorModel.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 17/07/24.
//

import Foundation
import UIKit

enum ErrorPresentationStyle: String {

    case bottomSheet = "bottom_sheet"
    case toast = "toast"
    case fullBottomSheet = "full_bottom_sheet"
    case alert = "alert"
}

enum ErrorType: String {
    case networkError = "network_error"
    case internetError = "internet_error"
    case defaultError = "default_error"
}


struct ErrorModel: Error {
    let title, subtitle, imageUrl: String?
    let errorType: ErrorType
    let presentationStyle: ErrorPresentationStyle
}


struct BottomSheetButton {
    let text: String
    let action: (()->Void)?
}



