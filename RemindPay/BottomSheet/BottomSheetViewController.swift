//
//  BottomSheetViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 01/08/24.
//

import UIKit


struct BottomSheetViewModel {
    let image: UIImage?
    let title: String
    let subtitle: String
    let bottomSheetAction: BottomSheetButton
}

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

    @objc func primaryButtonClicked() {
        primaryAction?()
        dismiss(animated: true)
    }

    func configure(using vm: BottomSheetViewModel) {
        if let image = vm.image {
            imageView.image = image
        }
        titleView.text = vm.title
        subtitleView.text = vm.subtitle
        primaryButton.setTitle(vm.bottomSheetAction.text, for: .normal)
        primaryAction = vm.bottomSheetAction.action
        secondaryButton.isHidden = true
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
        image.tintColor = .systemPink
        image.contentMode = .scaleAspectFit
//        image.backgroundColor = .blue
        imageView.setTranslatesMask()
        let leading = imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let top = imageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20)
        let height = imageView.heightAnchor.constraint(equalToConstant: 50)
        let width = imageView.widthAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([leading, top, height, width])
    }

    private func setupTitleView() {
        let label = UILabel()
//        label.backgroundColor = .yellow
        titleView = label
        label.text = "Something went wrong"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.numberOfLines = 0
        containerView.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20)
        let top = label.topAnchor.constraint(greaterThanOrEqualTo: containerView.topAnchor, constant: 12)
        let centerY = label.centerYAnchor.constraint(greaterThanOrEqualTo: imageView.centerYAnchor)
        let trailing = label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        NSLayoutConstraint.activate([leading, centerY, trailing, top])
    }

    private func setupSubtitleView() {
        let label = UILabel()
//        label.backgroundColor = .orange
        label.font  = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = .gray
        
        subtitleView = label
        label.text = "Something went wrong, Something went wrong, Something went wrong, Something went wrong, Something went wrong, Something went wrong, Something went wrong,  "
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.numberOfLines = 0
        containerView.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: imageView.leadingAnchor)
        let top = label.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 12)
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
        let top = container.topAnchor.constraint(equalTo: subtitleView.bottomAnchor, constant: 10)
        let bottom = container.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor)
        let height = container.heightAnchor.constraint(equalToConstant: 60)
        NSLayoutConstraint.activate([leading, trailing, top, bottom, height])
    }

    private func setupPrimaryButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)
        button.setTitleColor(.white, for: .normal)
        primaryButton = button
        button.addTarget(self, action: #selector(primaryButtonClicked), for: .touchUpInside)
        buttonContainer.addArrangedSubview(button)
        button.setTitle("Primary Button", for: .normal)
        button.tintColor = .black
    }

    private func setupSecondaryButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)
        button.setTitleColor(.white, for: .normal)
        secondaryButton = button
        buttonContainer.addArrangedSubview(button)
        button.setTitle("Secondary Button", for: .normal)
        button.tintColor = .black
    }
}

