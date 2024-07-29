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

    private var detailContainerView: UIStackView!

    private var nameView, phoneView, weightView, heightView, joinedView, startingView, expiryView: PlaceholderTextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavBar()
    }

    private func setupNavBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .white
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.compactScrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = .white
    }

    private func setup() {
        setupScrollView()
        setupContainer()
        setupImageView()
        setupDetailContainer()
        setupNameView()
        setupPhoneView()
        setupWeightHeightContainer()
        setupAddressView()
        setupExistingDiseaseView()
        setupJoiningExpiryContainer()
        setupPaymentView()
        setupCreateButton()
    }

    private func setupScrollView() {
        let scrollView = UIScrollView()
        scrollView.delegate = self
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

    private func setupDetailContainer() {
        let container = UIStackView()
        detailContainerView = container
        container.spacing = 30
        container.axis = .vertical
        container.backgroundColor = .white
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, trailing, top])
    }

    private func setupNameView() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        nameContainer = container
        let label = getLabel(text: "Name")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "Pranjal Agarwal")
        container.addArrangedSubview(tf)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        detailContainerView.addArrangedSubview(container)
    }

    private func setupPhoneView() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        phoneContainer = container
        let label = getLabel(text: "Phone")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "8291375546")
        container.addArrangedSubview(tf)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        detailContainerView.addArrangedSubview(container)
    }

    private func setupWeightHeightContainer() {
        let container = UIStackView()
        container.spacing = 20
        detailContainerView.addArrangedSubview(container)

        let sContainer = UIStackView()
        sContainer.axis = .vertical
        let label1 = getLabel(text: "Weight in kgs")
        label1.numberOfLines = 0
        let tv1 = getTextView(text: "80")
        let sep1 = getSeparator()
        sContainer.addArrangedSubview(label1)
        sContainer.addArrangedSubview(tv1)
        sContainer.addArrangedSubview(sep1)

        let eContainer = UIStackView()
        eContainer.axis = .vertical
        let label2 = getLabel(text: "Height in cms")
        let tv2 = getTextView(text: "180")
        let sep2 = getSeparator()
        eContainer.addArrangedSubview(label2)
        eContainer.addArrangedSubview(tv2)
        eContainer.addArrangedSubview(sep2)

        container.addArrangedSubview(sContainer)
        container.addArrangedSubview(eContainer)
    }

    private func setupAddressView() {
        let container = UIStackView()
        addressContainer = container
        container.axis = .vertical
        container.spacing = 0
        let label = getLabel(text: "Current Address")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "Manas hospital", isSeparatorFullLength: true)
        container.addArrangedSubview(tf)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        detailContainerView.addArrangedSubview(container)
    }

    private func setupExistingDiseaseView() {
        let container = UIStackView()
        diseaseContainer = container
        container.axis = .vertical
        container.spacing = 0
        let label = getLabel(text: "Existing disease")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "Fracture in left leg", isSeparatorFullLength: true)
        container.addArrangedSubview(tf)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        detailContainerView.addArrangedSubview(container)
    }

    private func setupJoiningExpiryContainer() {
        let container = UIStackView()
        container.spacing = 20
        detailContainerView.addArrangedSubview(container)

        let sContainer = UIStackView()
        sContainer.axis = .vertical
        let label1 = getLabel(text: "Plan Starting date")
        label1.numberOfLines = 0
        let tv1 = getTextView(text: "20-07-2024")
        let sep1 = getSeparator()
        sContainer.addArrangedSubview(label1)
        sContainer.addArrangedSubview(tv1)
        sContainer.addArrangedSubview(sep1)

        let eContainer = UIStackView()
        eContainer.axis = .vertical
        let label2 = getLabel(text: "Plan expiry date")
        let tv2 = getTextView(text: "20-12-2024")
        let sep2 = getSeparator()
        eContainer.addArrangedSubview(label2)
        eContainer.addArrangedSubview(tv2)
        eContainer.addArrangedSubview(sep2)

        container.addArrangedSubview(sContainer)
        container.addArrangedSubview(eContainer)
    }

    private func setupPaymentView() {
        let container = UIStackView()
        paymentContainer = container
        container.axis = .vertical
        container.spacing = 0
        let label = getLabel(text: "Payment amount")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "₹2000", isSeparatorFullLength: false)
        container.addArrangedSubview(tf)
        let sep = getSeparator()
        container.addArrangedSubview(sep)
        detailContainerView.addArrangedSubview(container)
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
        let top = button.topAnchor.constraint(equalTo: detailContainerView.bottomAnchor, constant: 40)
        let bottom = button.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        let width = button.widthAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([centerX, bottom, width, top])
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationController?.navigationBar.isHidden = scrollView.contentOffset.y > -87
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
        let height = separator.heightAnchor.constraint(equalToConstant: 1)
        NSLayoutConstraint.activate([height])
        return separator
    }

    private func getTextView(text: String, isSeparatorFullLength: Bool = true) -> PlaceholderTextView {
        let tv = PlaceholderTextView()
        tv.placeholderText = text
        tv.delegate = self
        tv.isScrollEnabled = false
        tv.textContainerInset = UIEdgeInsets(top: 8, left: 2, bottom: 4, right: 8)
        tv.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        tv.setTranslatesMask()
        let height = tv.heightAnchor.constraint(greaterThanOrEqualToConstant: 25)
        NSLayoutConstraint.activate([height])
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
