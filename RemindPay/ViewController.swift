//
//  ViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CardBackground")
        let button = UIButton()
        view.addSubview(button)
        button.setTitle("Click me", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(clickMe), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }

    @objc func clickMe() {
        presentBottomSheet()
    }


    func presentBottomSheet() {
        let bottomSheetTransitioningDelegate = BottomSheetTransitionDelegate(of: .init(width: view.bounds.width, height: 300))
        let bottomSheetVC = BottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .custom
        bottomSheetVC.transitioningDelegate = bottomSheetTransitioningDelegate
        present(bottomSheetVC, animated: true)
    }



}

