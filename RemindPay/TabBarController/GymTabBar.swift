//
//  GymTabBar.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 23/07/24.
//

import UIKit

final class GymTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .systemPink
    }
}
