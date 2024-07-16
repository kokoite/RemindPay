//
//  Utility+View.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//

import UIKit

extension UIView {

    func setTranslatesMask() {
        translatesAutoresizingMaskIntoConstraints = false
    }

    func pinToEdges(in view: UIView) {
        let leading = leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let top = topAnchor.constraint(equalTo: view.topAnchor)
        let bottom = bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }

    func pinToSafeEdges(in view: UIView) {
        let leading = leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let trailing = trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        let top = topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let bottom = bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }
}
