//
//  Utility.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 31/07/24.
//

import Foundation

func getTodaysDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MM-yyyy"
    return formatter.string(from: date)
}
