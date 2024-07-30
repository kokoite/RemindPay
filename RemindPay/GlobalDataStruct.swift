//
//  GlobalDataStruct.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 30/07/24.
//

import Foundation
import UIKit

enum ImageType {
    case system(name: String)
    case resource(name: String)
}

enum BackgroundType {
    case normal(color: UIColor)
    case gradient(colors: [CGColor], type: GradientType)
}

enum GradientType {
    case vertical
    case horizontal
    case diagonal
}
