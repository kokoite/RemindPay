//
//  CreateUserViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 19/07/24.
//

import UIKit

class CreateUserViewController: UIViewController {
    
    private var containerScrollView: UIScrollView!
    private var containerView: UIView!
    private var imageView: UIImageView!
    private var nameContainer, phoneContainer, heightContainer, weightContainer, addressContainer, diseaseContainer, joiningContainer, expiryContainer, joinedContainer, paymentContainer: UIStackView!
    private var createButton: UIButton!

    private var nameView, phoneView, weightView, heightView, joinedView, startingView, expiryView: PlaceholderTextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupScrollView()
        setupContainer()
        setupImageView()
        setupNameView()
        setupPhoneView()
        setupWeightView()
        setupHeightView()
        setupAddressView()
        setupExistingDiseaseView()
        setupJoiningView()
        setupExpiryView()
        setupJoinedView()
        setupPaymentView()
        setupCreateButton()
    }

    private func setupScrollView() {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        containerScrollView = scrollView
        view.addSubview(scrollView)
        scrollView.setTranslatesMask()
        scrollView.pinToEdges(in: view)
        scrollView.showsVerticalScrollIndicator = false
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        containerScrollView.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: containerScrollView)
        container.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
        container.backgroundColor = .white
    }


    private func setupImageView() {
        let image = UIImageView()
        imageView = image
        image.isUserInteractionEnabled = true
        image.image = UIImage(systemName: "camera.circle.fill")
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        image.backgroundColor = .white
        containerView.addSubview(image)
        image.setTranslatesMask()
        let centerX = image.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let top = image.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 10)
        let height = image.heightAnchor.constraint(equalToConstant: 150)
        let width = image.widthAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([centerX, top, height ,width])
        image.layer.cornerRadius = 75
        image.clipsToBounds = true
    }

    private func setupNameView() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 6
        nameContainer = container
        containerView.addSubview(container)
        let label = getLabel(text: "Name")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "Pranjal Agarwal", isSeparatorFullLength: true)
        container.addArrangedSubview(tf)
        let separator = getSeparator(isFullLength: true)
        container.addArrangedSubview(separator)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let top = container.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupPhoneView() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 6
        containerView.addSubview(container)
        phoneContainer = container
        let label = getLabel(text: "Phone")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "8291375546", isSeparatorFullLength: true)
        container.addArrangedSubview(tf)
        let separator = getSeparator(isFullLength: true)
        container.addArrangedSubview(separator)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: nameContainer.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: nameContainer.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }
//
    private func setupWeightView() {
        let container = UIStackView()
        weightContainer = container
        container.axis = .vertical
        container.spacing = 6
        let label = getLabel(text: "Weight")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "58 kgs", isSeparatorFullLength: false)
        container.addArrangedSubview(tf)
        let separator = getSeparator(isFullLength: false)
        container.addArrangedSubview(separator)
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: phoneContainer.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: phoneContainer.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupHeightView() {
        let container = UIStackView()
        heightContainer = container
        containerView.addSubview(container)
        container.axis = .vertical
        container.spacing = 6
        let label = getLabel(text: "Height")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "180 cm", isSeparatorFullLength: false)
        container.addArrangedSubview(tf)
        let separator = getSeparator(isFullLength: false)
        container.addArrangedSubview(separator)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: weightContainer.trailingAnchor, constant: 20)
        let top = container.topAnchor.constraint(equalTo: weightContainer.topAnchor)
        NSLayoutConstraint.activate([leading, top])
    }


    private func setupAddressView() {
        let container = UIStackView()
        addressContainer = container
        container.axis = .vertical
        container.spacing = 6
        let label = getLabel(text: "Current Address")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "Manas hospital", isSeparatorFullLength: true)
        container.addArrangedSubview(tf)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: weightContainer.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: weightContainer.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupExistingDiseaseView() {
        let container = UIStackView()
        diseaseContainer = container
        container.axis = .vertical
        container.spacing = 6
        let label = getLabel(text: "Existing disease")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "Fracture in left leg", isSeparatorFullLength: true)
        container.addArrangedSubview(tf)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: addressContainer.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: addressContainer.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupJoiningView() {
        let container = UIStackView()
        joiningContainer = container
        container.axis = .vertical
        container.spacing = 6
        let label = getLabel(text: "Plan Starting")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "20-07-2024", isSeparatorFullLength: false)
        container.addArrangedSubview(tf)
        let separator = UIView()
        separator.backgroundColor = .lightGray
        container.addArrangedSubview(separator)
        separator.setTranslatesMask()
        separator.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.4).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: diseaseContainer.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: diseaseContainer.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupExpiryView() {
        let container = UIStackView()
        weightContainer = container
        container.axis = .vertical
        container.spacing = 6
        let label = getLabel(text: "Plan Expiry")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "20-07-2024", isSeparatorFullLength: false)
        container.addArrangedSubview(tf)
        let separator = UIView()
        separator.backgroundColor = .lightGray
        container.addArrangedSubview(separator)
        separator.setTranslatesMask()
        separator.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.4).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: joiningContainer.trailingAnchor, constant: 20)
        let top = container.topAnchor.constraint(equalTo: joiningContainer.topAnchor)
        NSLayoutConstraint.activate([leading, top])
    }


    private func setupJoinedView() {
        let container = UIStackView()
        joinedContainer = container
        container.axis = .vertical
        container.spacing = 6
        let label = getLabel(text: "Gym joined date")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "20-07-2024", isSeparatorFullLength: false)
        container.addArrangedSubview(tf)
        let separator = getSeparator(isFullLength: false)
        container.addArrangedSubview(separator)
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: joiningContainer.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: joiningContainer.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupPaymentView() {
        let container = UIStackView()
        paymentContainer = container
        container.axis = .vertical
        container.spacing = 6
        let label = getLabel(text: "Payment amount")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "2000", isSeparatorFullLength: false)
        container.addArrangedSubview(tf)
        let separator = UIView()
        separator.backgroundColor = .lightGray
        container.addArrangedSubview(separator)
        separator.setTranslatesMask()
        separator.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.4).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: joinedContainer.trailingAnchor, constant: 20)
        let top = container.topAnchor.constraint(equalTo: joinedContainer.topAnchor)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupCreateButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        let button = UIButton(configuration: config)
        createButton = button
        button.tintColor = .black
        button.setTitle("Create User", for: .normal)
        containerView.addSubview(button)
        button.setTranslatesMask()
        let centerX = button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let top = button.topAnchor.constraint(equalTo: joinedContainer.bottomAnchor, constant: 40)
        let bottom = button.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        let width = button.widthAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([centerX, bottom, width, top])
    }

    private func getLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
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

    private func getTextView(text: String, isSeparatorFullLength: Bool) -> PlaceholderTextView {
        let tv = PlaceholderTextView()
        let wid = isSeparatorFullLength ? view.bounds.width*0.9: view.bounds.width * 0.4
        tv.placeholderText = text
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
}


extension CreateUserViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        guard let textView = textView as? PlaceholderTextView else { return }
        if(textView.text.isEmpty) {
            textView.showPlaceholder()
        } else if (textView.text.count == 1) {
            textView.hidePlaceholder()
        }
    }
}
