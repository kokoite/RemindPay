//
//  ApplicationWorker.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 01/08/24.
//

import Foundation

final class ApplicationWorker {
    static let instance = ApplicationWorker()

    private init() { }

    func hasUserAlreadyJoined() -> Bool {
        let decoder = JSONDecoder()
        guard let data = UserDefaults.standard.data(forKey: "user") else { return false }
        do {
            let _ = try decoder.decode(User.self, from: data)
            return true
        } catch(let error) {
            print("Unable to fetch user from user defaults\(error.localizedDescription)")
        }
        return false
    }
}
