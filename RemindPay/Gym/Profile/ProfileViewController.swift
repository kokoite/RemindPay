//
//  ProfileViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 20/07/24.
//

import UIKit

final class ProfileViewController: UIViewController {

    private var containerScrollView: UIScrollView!
    private var containerView: UIView!
    private var imageView: UIImageView!

    private var nameContainer, phoneContainer, gymNameContainer,
                experienceContainer, membershipTypeContainer,
                membershipContainer, gymAddressContainer, gymServiceContainer: UIStackView!
    private var editButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @objc func editButtonClicked() {
        print("Edit button clicked")
    }

    private func setup() {
        setupScrollView()
        setupContainer()
        setupImageView()
        setupName()
        setupGymName()
        setupPhone()
        setupExperience()
        setupMembershipType()
        setupMembershipExpiry()
        setupEditButton()
        setupGymAddress()
        setupGymServices()
    }


    private func setupScrollView() {
        let scrollView = UIScrollView()
        containerScrollView = scrollView
        scrollView.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.setTranslatesMask()
        scrollView.pinToEdges(in: view)
        scrollView.showsVerticalScrollIndicator = false
    }

    private func setupContainer() {
        let container = UIView()
        container.backgroundColor = .white
        containerView = container
        containerScrollView.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: containerScrollView)
        container.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
    }

    private func setupImageView() {
        let image = UIImageView()
        imageView = image
        image.image = UIImage(named: "happyFace")
        image.backgroundColor = .gray
        image.layer.cornerRadius = 75
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        containerView.addSubview(image)
        image.setTranslatesMask()
        let top = image.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor)
        let centerX = image.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let height = image.heightAnchor.constraint(equalToConstant: 150)
        let width = image.widthAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([centerX, height, width, top])
    }

    private func setupName() {
        let container = getContainer(labelName: "Name", labelContent: "Pranjal")
        nameContainer = container
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let top = container.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupGymName() {
        let container = getContainer(labelName: "Gym Name", labelContent: "Fitness with Pranjal")
        gymNameContainer = container
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupPhone() {
        let container = getContainer(labelName: "Phone", labelContent: "8291376455", isFullLengthSeparator: false)
        phoneContainer = container
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: gymNameContainer.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: gymNameContainer.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupExperience() {
        let container = getContainer(labelName: "Gym Experience", labelContent: "5 years", isFullLengthSeparator: false)
        experienceContainer = container
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: phoneContainer.trailingAnchor, constant: 20)
        let top = container.topAnchor.constraint(equalTo: phoneContainer.topAnchor)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupMembershipType() {
        let container = getContainer(labelName: "Membership Type", labelContent: "Free", isFullLengthSeparator: false)
        membershipTypeContainer = container
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: phoneContainer.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: phoneContainer.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupMembershipExpiry() {
        let container = getContainer(labelName: "Memebership Expiry", labelContent: "20-07-2024", isFullLengthSeparator: false)
        membershipContainer = container
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: membershipTypeContainer.trailingAnchor, constant: 20)
        let top = container.topAnchor.constraint(equalTo: membershipTypeContainer.topAnchor)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupEditButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "pencil")
        let button = UIButton(configuration: config)
        button.clipsToBounds = true
        editButton = button
        button.layer.cornerRadius = 30
        button.tintColor = .black
        button.backgroundColor = .white
        containerScrollView.addSubview(button)
        button.setTranslatesMask()
        let height = button.heightAnchor.constraint(equalToConstant: 60)
        let width = button.widthAnchor.constraint(equalToConstant: 60)
        let trailng = button.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor, constant: -20)
        let bottom = button.bottomAnchor.constraint(equalTo: containerScrollView.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        NSLayoutConstraint.activate([height, width, trailng, bottom])
    }

    private func setupGymPhotos() {
        // TODO :- Near future if everything works out
    }

    private func setupGymAddress() {
        let container = getContainer(labelName: "Gym Address", labelContent: "Manas Hospital", isFullLengthSeparator: true)
        gymAddressContainer = container
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: membershipTypeContainer.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: membershipTypeContainer.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupGymServices() {
        let container = getContainer(labelName: "Gym services", labelContent: "Weight Loss, Height Gain, Weight Gain, Strength training", isFullLengthSeparator: true)
        gymServiceContainer = container
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: gymAddressContainer.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: gymAddressContainer.bottomAnchor, constant: 40)
        let bottom = container.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([leading, top, bottom])
    }

    //

    private func getContainer(labelName: String, labelContent: String, isFullLengthSeparator: Bool = true) -> UIStackView {
        let container = UIStackView()
        containerView.addSubview(container)
        container.axis = .vertical
        container.spacing = 6
        let label = getLabel(text: labelName)
        container.addArrangedSubview(label)

        let labelContent = getLabelContent(text: labelContent)
        container.addArrangedSubview(labelContent)

        let separator = getSeparator(isFullLength: isFullLengthSeparator)
        container.addArrangedSubview(separator)
        return container
    }


    private func getLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }

    private func getLabelContent(text: String) -> UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = text
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }

    private func getSeparator(isFullLength: Bool = true) -> UIView {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.setTranslatesMask()
        let separatorWidth = isFullLength ? view.bounds.width * 0.9 : view.bounds.width * 0.4
        let width = separator.widthAnchor.constraint(equalToConstant: separatorWidth)
        let height = separator.heightAnchor.constraint(equalToConstant: 1)
        NSLayoutConstraint.activate([width, height])
        return separator
    }


}
