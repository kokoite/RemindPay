//
//  FilterBottomSheetViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 19/07/24.
//

import UIKit

final class FilterBottomSheetViewController: UIViewController {

    private var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        let container = UIView()
        containerView = container
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)
        container.backgroundColor = .white
        container.layer.cornerRadius = 40
        container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}
