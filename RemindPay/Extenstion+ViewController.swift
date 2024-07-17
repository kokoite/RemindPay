//
//  Extenstion+ViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 17/07/24.
//

import UIKit

protocol DynamicContentController: UIViewController {
    var requiredSize: CGSize? { get }
}
