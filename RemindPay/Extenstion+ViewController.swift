//
//  Extenstion+ViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 17/07/24.
//

import UIKit

final class LightStatusNavigationController: UINavigationController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return childForStatusBarStyle?.preferredStatusBarStyle ?? .lightContent
    }

    override var childForStatusBarStyle: UIViewController? {
        return visibleViewController
    }
}
