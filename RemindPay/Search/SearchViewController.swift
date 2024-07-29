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
    private var animationView: DotLottieAnimationView!
    private var titleView: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    private func setup() {
        setupScrollView()
        setupContainer()
        setupAnimationView()

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
        Task {
            do {
                let vm = DotLottieAnimation(webURL: "https://lottie.host/45c80518-a731-4ffd-a8c5-0e26e5982dc1/TiQknrqAh5.json", config: .init(autoplay: true, loop: true))
                let container: DotLottieAnimationView = vm.view()
                DispatchQueue.main.async { [weak self] in
                    guard let self else { return }
                    self.animationView = container
                    container.backgroundColor = .white
                    self.containerView.addSubview(container)
                    container.setTranslatesMask()
                    let centerX = container.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
                    let centerY = container.centerYAnchor.constraint(equalTo: view.centerYAnchor)
                    let width = container.widthAnchor.constraint(equalToConstant: self.view.bounds.width * 0.9)
                    let height = container.heightAnchor.constraint(equalToConstant: 400)
                    NSLayoutConstraint.activate([centerX, centerY, height, width])
                    setupTitle()
                }
            }
        }
    }

    private func setupTitle() {
        let label = UILabel()
        label.text = "Will be available soon"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .gray
        containerView.addSubview(label)
        label.setTranslatesMask()
        let centerX = label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let width = label.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8)
        let top = label.topAnchor.constraint(equalTo: animationView.bottomAnchor, constant: -40)
        NSLayoutConstraint.activate([centerX, width, top])
    }
}
