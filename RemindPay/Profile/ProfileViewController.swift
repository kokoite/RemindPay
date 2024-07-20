//
//  ProfileViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 20/07/24.
//

import UIKit

class ProfileViewController: UIViewController {


    private var containerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupContainer()
    }

    private func setupContainer() {
        let container = UIView()
        container.backgroundColor = .yellow
        containerView = container
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)
    }

}
