//
//  ProfileViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 20/07/24.
//

import UIKit

final class GymProfileViewController: UIViewController {

    private var containerScrollView: UIScrollView!
    private var containerView: UIView!
    private var imageView: UIImageView!

    private var nameContainer, phoneContainer, gymNameContainer,
                experienceContainer, membershipTypeContainer,
                membershipContainer, gymAddressContainer, gymServiceContainer: UIStackView!
    private var nameView, gymNameView, phoneView, experienceView, membershipTypeView, membershipExpiryView, gymAddressView, gymServiceView: PlaceholderTextView!
    private var editButton: UIButton!
    private var buttonState: Bool = true
    // true denote viewing state false denote editing state

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)


    }

    @objc func editButtonClicked() {
        if(buttonState) {
            // makeEditable
            updateEditablity(isEditable: true)
            // Todo :- update image of edit button
        } else {
            editButton.configuration?.image = UIImage(systemName: "pencil")
            updateEditablity(isEditable: false)
        }

        buttonState = !buttonState
    }

    private func updateEditablity(isEditable: Bool) {
        [nameView, phoneView, gymNameView, experienceView, gymAddressView, gymServiceView].forEach { elm in
            elm?.isEditable = isEditable
        }
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
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 6
        let label = getLabel(text: "Name")
        container.addArrangedSubview(label)
        let tv = getTextView(text: "Pranjal Agarwal", isSeparatorFullLength: true)
        nameView = tv
        container.addArrangedSubview(tv)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        nameContainer = container
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let top = container.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupGymName() {
        let container = UIStackView()
        containerView.addSubview(container)
        container.axis = .vertical
        container.spacing = 6
        let label = getLabel(text: "Gym Name")
        container.addArrangedSubview(label)
        let tv = getTextView(text: "Fitness with Pranjal", isSeparatorFullLength: true)
        gymNameView = tv
        container.addArrangedSubview(tv)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        gymNameContainer = container
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupPhone() {
        let container = UIStackView()
        containerView.addSubview(container)
        container.axis = .vertical
        container.spacing = 6
        let label = getLabel(text: "Phone")
        container.addArrangedSubview(label)

        let tv = getTextView(text: "8209131934", isSeparatorFullLength: false)
        phoneView = tv
        container.addArrangedSubview(tv)

        let separator = getSeparator(isFullLength: false)
        container.addArrangedSubview(separator)

        phoneContainer = container
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: gymNameContainer.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: gymNameContainer.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupExperience() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 6
        containerView.addSubview(container)
        let label = getLabel(text: "Gym Experience")
        container.addArrangedSubview(label)

        let tv = getTextView(text: "5 years", isSeparatorFullLength: false)
        experienceView = tv
        container.addArrangedSubview(tv)
        let separator = getSeparator(isFullLength: false)
        container.addArrangedSubview(separator)
        experienceContainer = container
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: phoneContainer.trailingAnchor, constant: 20)
        let top = container.topAnchor.constraint(equalTo: phoneContainer.topAnchor)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupMembershipType() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 6
        containerView.addSubview(container)
        let label = getLabel(text: "Membership Type")
        container.addArrangedSubview(label)

        let tv = getTextView(text: "Free", isSeparatorFullLength: false)
        membershipTypeView = tv
        container.addArrangedSubview(tv)

        let separator = getSeparator(isFullLength: false)
        container.addArrangedSubview(separator)
        membershipTypeContainer = container
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: phoneContainer.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: phoneContainer.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupMembershipExpiry() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 6
        containerView.addSubview(container)
        let label = getLabel(text: "Membership expiry")
        container.addArrangedSubview(label)
        let tv = getTextView(text: "20-07-204", isSeparatorFullLength: false)
        membershipExpiryView = tv
        container.addArrangedSubview(tv)
        let separator = getSeparator(isFullLength: false)
        container.addArrangedSubview(separator)
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
        button.contentMode = .scaleAspectFit
        editButton = button
        button.layer.cornerRadius = 30
        button.tintColor = .black
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(editButtonClicked), for: .touchUpInside)
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
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 6
        let label = getLabel(text: "Gym Address")
        container.addArrangedSubview(label)

        let tv = getTextView(text: "Manas hospital", isSeparatorFullLength: true)

        gymAddressView = tv
        container.addArrangedSubview(tv)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        containerView.addSubview(container)
        gymAddressContainer = container
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: membershipTypeContainer.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: membershipTypeContainer.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupGymServices() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 6
        containerView.addSubview(container)
        let label = getLabel(text: "Gym services")
        container.addArrangedSubview(label)
        let tv = getTextView(text: "Weight Loss, Height Gain, Weight Gain", isSeparatorFullLength: true)
        gymServiceView = tv
        container.addArrangedSubview(tv)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
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

    private func getTextView(text: String, isSeparatorFullLength: Bool) -> PlaceholderTextView {
        let tv = PlaceholderTextView()
        let wid = isSeparatorFullLength ? view.bounds.width*0.9: view.bounds.width * 0.4
        tv.placeholderText = text
        tv.isEditable = false
        tv.delegate = self
        tv.isScrollEnabled = false
        tv.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 4, right: 8)
        tv.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        tv.setTranslatesMask()
        let width = tv.widthAnchor.constraint(equalToConstant: wid)
        let height = tv.heightAnchor.constraint(greaterThanOrEqualToConstant: 25)
        NSLayoutConstraint.activate([height, width])
        return tv
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

extension GymProfileViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        guard let textView = textView as? PlaceholderTextView else { return }
        if(textView.text.isEmpty) {
            textView.showPlaceholder()
        } else if(textView.text.count == 1) {
            textView.hidePlaceholder()
        }
    }
}
