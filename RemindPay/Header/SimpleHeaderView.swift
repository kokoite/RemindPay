//
//  SimpleHeaderView.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 22/07/24.
//

import UIKit

final class SimpleHeaderView: UIView {

    private var containerView: UIView!
    private var imageView: UIImageView!
    private var titleView: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        if let gradientLayer = containerView.layer.sublayers?.first as? CAGradientLayer {
            gradientLayer.frame = bounds
        }
    }

    func configure(color: UIColor) {
        titleView.textColor = .white
        imageView.backgroundColor = .white
        addGradient(color)
    }

    private func addGradient(_ color: UIColor) {
        let grd = CAGradientLayer()
        grd.colors = [color.cgColor, UIColor.black.cgColor]
        grd.locations = [0.5, 0.9]
        containerView.layer.insertSublayer(grd, at: 0)
    }

    private func setup() {
//        backgroundColor = .yellow
        setupContainer()
        setupImageView()
        setupTitle()
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        container.backgroundColor = .white
        addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: self)
    }

    private func setupImageView() {
        let image = UIImageView()
        imageView = image
        image.backgroundColor = .gray
        containerView.addSubview(image)
        image.setTranslatesMask()
        let top = image.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 12)
        let leading = image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12)
        let height = image.heightAnchor.constraint(equalToConstant: 60)
        let width = image.widthAnchor.constraint(equalToConstant: 60)
        NSLayoutConstraint.activate([height, width, top, leading])
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
    }

    private func setupTitle() {
        let label = UILabel()
        titleView = label
        label.text = "Welcome back, Pranjal"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        containerView.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12)
        let centerY = label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        let trailing = label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        NSLayoutConstraint.activate([leading, centerY, trailing])
    }
}
