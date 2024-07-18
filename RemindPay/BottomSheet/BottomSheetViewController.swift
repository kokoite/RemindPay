//
//  BottomSheetViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 17/07/24.
//

import UIKit


final class BottomSheetViewController: UIViewController {

    private var containerView: UIView!
    private var primaryButton, secondaryButton: UIButton!
    private var titleView, subtitleView: UILabel!
    private var imageView: UIImageView!
    private var buttonContainer: UIStackView!
    private var primaryAction: (() -> Void)? = nil
    private var secondaryAction: (() -> Void)? = nil


    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func configure() {
        
    }

    private func setup() {
        setupContainer()
        setupImageView()
        setupTitleView()
        setupSubtitleView()
        setupButtonContainer()
        setupPrimaryButton()
        setupSecondaryButton()
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)
        container.backgroundColor = .white
        container.layer.cornerRadius = 40
        container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    private func setupImageView() {
        let image = UIImageView()
        imageView = image
        containerView.addSubview(image)
        image.image = UIImage(systemName: "lightbulb.min.badge.exclamationmark.fill")
        image.tintColor = .red
        imageView.setTranslatesMask()
        let leading = imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let top = imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20)
        let height = imageView.heightAnchor.constraint(equalToConstant: 60)
        let width = imageView.widthAnchor.constraint(equalToConstant: 60)
        NSLayoutConstraint.activate([leading, top, height, width])
    }

    private func setupTitleView() {
        let label = UILabel()
        titleView = label
        label.text = "Something went wrong"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        containerView.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20)
        let centerY = label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        let trailing = label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        NSLayoutConstraint.activate([leading, centerY, trailing])
    }

    private func setupSubtitleView() {
        let label = UILabel()
        subtitleView = label
        label.text = "Something went wrong, Something went wrong, Something went wrong, Something went wrong, Something went wrong, Something went wrong, Something went wrong,  "
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        containerView.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor)
        let top = label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12)
        let trailing = label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        NSLayoutConstraint.activate([leading, top, trailing])
    }

    private func setupButtonContainer() {
        let container = UIStackView()
        buttonContainer = container
        containerView.addSubview(container)
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
        container.spacing = 12
        container.distribution = .fillEqually
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        let top = container.topAnchor.constraint(equalTo: subtitleView.bottomAnchor, constant: 12)
        let bottom = container.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }

    private func setupPrimaryButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        let button = UIButton(configuration: config)
        primaryButton = button
        buttonContainer.addArrangedSubview(button)
        button.setTitle("Primary Button", for: .normal)
        button.tintColor = .systemBlue
    }

    private func setupSecondaryButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 10, bottom: 12, trailing: 10)
        let button = UIButton(configuration: config)
        secondaryButton = button
        buttonContainer.addArrangedSubview(button)
        button.setTitle("Secondary Button", for: .normal)
        button.tintColor = .systemBlue
    }
}
