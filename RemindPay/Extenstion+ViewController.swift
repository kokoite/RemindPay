//
//  Extenstion+ViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 17/07/24.
//

import UIKit

extension UINavigationController {


    open override var preferredStatusBarStyle: UIStatusBarStyle {
        print("Called")
        return .lightContent
    }

    open override var childForStatusBarStyle: UIViewController? {
        print("called")
        return visibleViewController
    }
}

final class LightStatusNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        print("status called")
        return childForStatusBarStyle?.preferredStatusBarStyle ?? .lightContent
    }

    override var childForStatusBarStyle: UIViewController? {
        print("Status called")
        return visibleViewController
    }
}
