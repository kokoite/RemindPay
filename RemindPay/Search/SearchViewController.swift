//
//  SearchViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 26/07/24.
//

import UIKit
import DotLottie

final class SearchViewController: UIViewController {
    
    private var containerView: UIView!
    private var scrollView: UIScrollView!
    private var animationView: UIView!
    private var titleView: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupScrollView()
        setupContainer()
        setupAnimationView()
        setupTitle()
    }

    private func setupScrollView() {
        let scrollView = UIScrollView()
        self.scrollView = scrollView
        view.addSubview(scrollView)
        scrollView.setTranslatesMask()
        scrollView.pinToEdges(in: view)
        scrollView.backgroundColor = .cardBackground
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        scrollView.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: scrollView)
        container.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }

    private func setupAnimationView() {
        let container = UIView()
        animationView = container
        container.backgroundColor = .systemPink
        containerView.addSubview(container)
        container.setTranslatesMask()
        let centerX = container.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let top = container.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20)
        let width = container.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9)
        let height = container.heightAnchor.constraint(equalToConstant: 400)
        NSLayoutConstraint.activate([centerX, top, height, width])
    }

    private func setupTitle() {
        let label = UILabel()
        label.text = "Work in progress. Will be available in future updates"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .justified
        label.textColor = .gray
        containerView.addSubview(label)
        label.setTranslatesMask()
        let centerX = label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let width = label.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8)
        let top = label.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: 20)
        NSLayoutConstraint.activate([centerX, width, top])
    }
}
