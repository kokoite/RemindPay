//
//  LottieView.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 03/08/24.
//

import UIKit
import Lottie

final class LottieView: UIView {

    private var containerView: UIStackView!
    private var animationView: LottieAnimationView!
    private var titleView: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func play() {
        animationView.play()
    }

    func pause() {
        animationView.pause()
    }

    func configure(using title: String) {
        titleView.text = title
    }

    private func setup() {
        setupContainer()
        setupAnimationView()
        setupTitleView()
    }

    private func setupContainer() {
        let container = UIStackView()
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
        
        containerView = container
        container.axis = .vertical
        addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: self)
    }

    private func setupAnimationView() {
        let animationView = LottieAnimationView(name: "lonelyAnimation")
        animationView.loopMode = .loop
        animationView.animationSpeed = 2
        self.animationView = animationView
        containerView.addArrangedSubview(animationView)
        animationView.setTranslatesMask()
        animationView.heightAnchor.constraint(equalToConstant: 400).isActive = true
    }

    private func setupTitleView() {
        let label = UILabel()
        label.text = "Currently no users, Please add more users"
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.setTranslatesMask()
        
        containerView.addArrangedSubview(label)
    }
}
