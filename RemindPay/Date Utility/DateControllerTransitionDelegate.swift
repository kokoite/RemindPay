//
//  DateControllerTransitionDelegate.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 04/08/24.
//

import Foundation

import UIKit

final class DateControllerTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return DateControllerPresentationController(presentedViewController: presented, presenting: presenting)
    }
}

final class DateControllerPresentationController: UIPresentationController {

    private var dimmingView: UIView!

    @objc func dismiss() {
        presentedViewController.dismiss(animated: true)
    }

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }

    private func setupDimmingView() {
        guard let containerView = containerView else { return }
        dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0
        containerView.insertSubview(dimmingView, at: 0)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        dimmingView.addGestureRecognizer(gesture)
    }
}
