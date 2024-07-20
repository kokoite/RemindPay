//
//  FilterBottomSheetViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 19/07/24.
//

import UIKit

enum FilterAction {
    case clearButton
    case expiryMonth
    case expiryWeek
    case inactive
    case active
    case planExpired
}

protocol FilterBottomSheetDelegate: AnyObject {
    func didClickOnButton(with action: FilterAction)
}

final class FilterBottomSheetViewController: UIViewController {

    private var containerView, buttonContainer: UIView!
    private var inactiveButton, expiryMonth, expiryWeek, clearButton, planExpiredButton, activeButton: UIButton!
    private var imageView: UIImageView!
    private var titleView: UILabel!
    weak var delegate: FilterBottomSheetDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupContainer()
        setupImageView()
        setupTitleView()
        setupButtonContainer()
        setupExpiryWeek()
        setupExpiryMonth()
        setupActiveButton()
        setupInactive()
        setupPlanExpired()
        setupClearButton()
    }

    @objc func clearButtonClicked() {
        delegate?.didClickOnButton(with: .clearButton)
    }

    @objc func expiryWeekClicked() {
        delegate?.didClickOnButton(with: .expiryWeek)
    }

    @objc func expiryMonthClicked() {
        delegate?.didClickOnButton(with: .expiryMonth)
    }

    @objc func planExpiredClicked() {
        delegate?.didClickOnButton(with: .planExpired)
    }

    @objc func inactiveButtonClicked() {
        delegate?.didClickOnButton(with: .inactive)
    }

    @objc func activeUserButtonClicked() {
        delegate?.didClickOnButton(with: .active)
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

    private func setupButtonContainer() {
        let container = UIView()
        buttonContainer = container
        containerView.addSubview(container)
        buttonContainer.setTranslatesMask()
        let centerX = container.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let top = container.topAnchor.constraint(equalTo: imageView.bottomAnchor)
        let bottom = container.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        NSLayoutConstraint.activate([centerX, top, bottom])
    }

    private func setupImageView() {
        let image = UIImageView()
        imageView = image
        image.image = UIImage(systemName: "line.3.horizontal.decrease.circle.fill")
        image.tintColor = .gray
        containerView.addSubview(image)
        image.backgroundColor = .white
        image.layer.cornerRadius = 30
        image.clipsToBounds = true
        image.setTranslatesMask()
        let height = image.heightAnchor.constraint(equalToConstant: 60)
        let width = image.widthAnchor.constraint(equalToConstant: 60)
        let leading = image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let top = image.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20)
        NSLayoutConstraint.activate([height, width, leading, top])
    }

    private func setupTitleView() {
        let title = UILabel()
        title.numberOfLines = 0
        titleView = title
        title.text = "Filter users based on below fields"
        title.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        title.textColor = .lightGray
        containerView.addSubview(title)
        title.setTranslatesMask()
        let leading = title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20)
        let top = title.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        let trailing = title.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        NSLayoutConstraint.activate([leading, top, trailing])

    }

    private func setupExpiryWeek() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)
        button.tintColor = .black
        expiryWeek = button
        button.setTitle("Expiry in 7 days", for: .normal)
        button.addTarget(self, action: #selector(expiryWeekClicked), for: .touchUpInside)
        buttonContainer.addSubview(button)
        button.setTranslatesMask()
        let leading = button.leadingAnchor.constraint(equalTo: buttonContainer.leadingAnchor, constant: 12)
        let top = button.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupExpiryMonth() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)
        expiryMonth = button
        button.tintColor = .black
        button.setTitle("Expiry in 30 days", for: .normal)
        button.addTarget(self, action: #selector(expiryMonthClicked), for: .touchUpInside)
        buttonContainer.addSubview(button)
        button.setTranslatesMask()
        let leading = button.leadingAnchor.constraint(equalTo: expiryWeek.trailingAnchor, constant: 20)
        let top = button.topAnchor.constraint(equalTo: expiryWeek.topAnchor)
        let trailing = button.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor, constant: -12)
        NSLayoutConstraint.activate([leading, top, trailing])
    }

    private func setupActiveButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)
        button.tintColor = .black
        activeButton = button
        button.setTitle("Active users", for: .normal)
        button.addTarget(self, action: #selector(activeUserButtonClicked), for: .touchUpInside)
        buttonContainer.addSubview(button)
        button.setTranslatesMask()
        let width = button.widthAnchor.constraint(equalTo: expiryWeek.widthAnchor)
        let top = button.topAnchor.constraint(equalTo: expiryWeek.bottomAnchor, constant: 20)
        let leading = button.leadingAnchor.constraint(equalTo: expiryWeek.leadingAnchor)
        NSLayoutConstraint.activate([leading, width, top])
    }

    private func setupInactive() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)
        inactiveButton = button
        button.tintColor = .black
        button.setTitle("Inactive users", for: .normal)
        button.addTarget(self, action: #selector(inactiveButtonClicked), for: .touchUpInside)
        buttonContainer.addSubview(button)
        button.setTranslatesMask()
        let top = button.topAnchor.constraint(equalTo: activeButton.topAnchor)
        let centerX = button.centerXAnchor.constraint(equalTo: expiryMonth.centerXAnchor)
        let width = button.widthAnchor.constraint(equalTo: expiryMonth.widthAnchor)
        let trailing = button.trailingAnchor.constraint(equalTo: buttonContainer.trailingAnchor, constant: -20)
        NSLayoutConstraint.activate([top, centerX, width])
    }

    private func setupPlanExpired() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)
        planExpiredButton = button
        button.tintColor = .black
        button.setTitle("Plan expired", for: .normal)
        button.addTarget(self, action: #selector(planExpiredClicked), for: .touchUpInside)
        buttonContainer.addSubview(button)
        button.setTranslatesMask()
        let top = button.topAnchor.constraint(equalTo: activeButton.bottomAnchor, constant: 20)
        let centerX = button.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor)
        let width = button.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.5)
        NSLayoutConstraint.activate([top, centerX, width])
    }

    private func setupClearButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)
        clearButton = button
        button.tintColor = .black
        button.setTitle("Clear all filters", for: .normal)
        button.addTarget(self, action: #selector(clearButtonClicked), for: .touchUpInside)
        buttonContainer.addSubview(button)
        button.setTranslatesMask()
        let centerX = button.centerXAnchor.constraint(equalTo: buttonContainer.centerXAnchor)
        let bottom = button.bottomAnchor.constraint(equalTo: buttonContainer.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        let width = button.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.6)
        let top = button.topAnchor.constraint(equalTo: planExpiredButton.bottomAnchor, constant: 20)
        NSLayoutConstraint.activate([centerX, bottom, top, width])
    }
}
