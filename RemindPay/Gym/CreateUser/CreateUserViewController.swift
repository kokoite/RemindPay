//
//  CreateUserViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 19/07/24.
//

import UIKit

class CreateUserViewController: UIViewController {
    
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
        containerView = container
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)
        container.backgroundColor = .systemMint
    }

}
