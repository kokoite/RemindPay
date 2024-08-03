//
//  DateUtility.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 03/08/24.
//

import Foundation


final class DateUtility {
    static let instance = DateUtility()

    private init() { }

    func convertStringToLong(date: String) -> CLongLong {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        guard let date = formatter.date(from: date) else { return 0}
        return CLongLong(date.timeIntervalSince1970)
    }

    func convertLongToString(date: CLongLong) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        let interval = TimeInterval(date)
        let dt = Date(timeIntervalSince1970: interval)
        return formatter.string(from: dt)
    }

    func getDate(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter.string(from: date)
    }
}
