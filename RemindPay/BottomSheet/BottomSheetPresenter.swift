//
//  BottomSheetPresenter.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 17/07/24.
//

import Foundation
import UIKit


final class BottomSheetPresenter {

}

final class BottomSheetTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

    private var requiredSize: CGSize?
    private var shouldDissmissOnTap: Bool = true
    private var dismissBlock: (() -> Void)? = nil

    init(of size: CGSize) {
        requiredSize = size
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BottomSheetPresentationController(presentedViewController: presented, presenting: presenting, of: requiredSize)
    }
}


final class BottomSheetPresentationController: UIPresentationController {

    private var requiredSize: CGSize?
    private var dimmingView: UIView!
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, of size: CGSize?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        requiredSize = size
//        setupDimmingView()
    }

    private func setupDimmingView() {
        guard let containerView = containerView else { return }
        dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0
        containerView.insertSubview(dimmingView, at: 0)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissBottomSheet))
        dimmingView.addGestureRecognizer(gesture)
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView else {
            return .zero
        }
        guard let frameSize = requiredSize else { return .init (x: 0, y: containerView.bounds.height - 300, width: containerView.bounds.width, height: 300)
        }
        let (slice, _) = containerView.bounds.divided(atDistance: frameSize.height, from: .maxYEdge)
        return slice
    }

    override func presentationTransitionWillBegin() {
        guard let containerView = containerView else { return }

        let dimmingView = UIView(frame: containerView.bounds)
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        dimmingView.alpha = 0
        containerView.insertSubview(dimmingView, at: 0)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissBottomSheet))
        dimmingView.addGestureRecognizer(gesture)

        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                dimmingView.alpha = 1
            })
        } else {
            dimmingView.alpha = 1
        }
    }

    override func dismissalTransitionWillBegin() {
        if let coordinator = presentedViewController.transitionCoordinator {
            coordinator.animate(alongsideTransition: { _ in
                self.containerView?.subviews.first?.alpha = 0
            })
        }
    }

    @objc func dismissBottomSheet() {
        presentedViewController.dismiss(animated: true)
    }

}
