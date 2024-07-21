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
        let button = PlaceholderTextView()
        button.placeholderText = "Enter your name"
        button.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8)
        button.font = UIFont.systemFont(ofSize: 16)
        view.addSubview(button)
        button.backgroundColor = .yellow
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        button.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        button.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.5).isActive = true
        button.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9).isActive = true
    }

    @objc func clickMe() {
        presentBottomSheet()
    }


    func presentBottomSheet() {
        let bottomSheetTransitioningDelegate = BottomSheetTransitionDelegate(of: .init(width: view.bounds.width, height: 300))
        let bottomSheetVC = ErrorBottomSheetViewController()
        bottomSheetVC.modalPresentationStyle = .custom
        bottomSheetVC.transitioningDelegate = bottomSheetTransitioningDelegate
        present(bottomSheetVC, animated: true)
    }



}

