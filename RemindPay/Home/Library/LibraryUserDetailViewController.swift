//
//  LibraryUserDetailViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 29/07/24.
//

//
//  TenantDetailViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 28/07/24.
//

import UIKit

final class LibraryUserDetailViewController: UIViewController {

    fileprivate var containerScrollView: UIScrollView!
    fileprivate var imageView: UIImageView!
    fileprivate var containerView, imageContainer, userDetailContainerView: UIView!
    fileprivate var nameView, phoneView, joinedDate, planStarted, planExpiry, addressView, isActiveView, paymentView
    : UILabel!

    fileprivate var nameContainer, phoneContainer, addressContainer, startExpiryContainer, paymentAmountDateContainer, joinedActiveContainer: UIStackView!

    private var editButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cardBackground
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .black
    }

    func configure() {

    }

    @objc func editButtonClicked() {
        print("Edit button clicked")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationController?.navigationBar.isHidden = scrollView.contentOffset.y > -87
    }

    private func setup() {
        setupScrollContainer()
        setupContainer()
        setupImageContainer()
        setupImage()
        setupUserDetailContainer()
        setupUserDetails()
        setupEditButton()
    }

    private func setupScrollContainer() {
        let container = UIScrollView()
        container.delegate = self
        container.backgroundColor = .cardBackground
        container.layer.cornerRadius = 20
        container.clipsToBounds = true
        containerScrollView = container
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)
        container.showsVerticalScrollIndicator = false
    }


    private func setupContainer() {
        let container = UIView()
        containerView = container
        container.layer.cornerRadius = 20
        container.clipsToBounds = true
        containerScrollView.addSubview(container)
        container.backgroundColor  = .cardBackground
        container.setTranslatesMask()
        container.pinToEdges(in: containerScrollView)
        container.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
    }

    private func setupImageContainer() {
        let container = UIView()
        imageContainer = container
        container.backgroundColor = .white
        container.layer.cornerRadius = 20
        container.clipsToBounds = true
        container.setTranslatesMask()
        containerView.addSubview(container)
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20)
        NSLayoutConstraint.activate([leading, top, trailing])
    }

    private func setupImage() {
        let container = UIImageView()
        imageView = container
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
        imageContainer.addSubview(container)
        container.image = UIImage(named: "happyFace")
        container.setTranslatesMask()
        let top = container.topAnchor.constraint(equalTo: imageContainer.topAnchor, constant: 12)
        let leading = container.leadingAnchor.constraint(equalTo: imageContainer.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: imageContainer.trailingAnchor, constant: -20)
        let height = container.heightAnchor.constraint(equalToConstant: 300)
        let bottom = container.bottomAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: -12)
        NSLayoutConstraint.activate([top, height, leading, trailing,  bottom])
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

}

// Tenant Detail Container
extension LibraryUserDetailViewController {

    fileprivate func setupUserDetailContainer() {
        let container = UIView()
        container.backgroundColor = .white
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
        userDetailContainerView = container
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 20)
        let bottom = container.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }

    fileprivate func setupUserDetails() {
        setupNameContainer()
        setupPhoneContainer()
        setupAddress()
        setupJoinedAndActive()
        setupPlanStartAndExpiry()
        setupPaymentDateAndAmount()
    }

    private func setupNameContainer() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        nameContainer = container
        container.backgroundColor = .white
        userDetailContainerView.addSubview(nameContainer)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: userDetailContainerView.leadingAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: userDetailContainerView.trailingAnchor)
        let top = container.topAnchor.constraint(equalTo: userDetailContainerView.topAnchor ,constant: 12)

        NSLayoutConstraint.activate([leading, trailing, top])
        let label = getLabel(text: "Name")
        let view = getLabelContentView(text: "Pranjal")

        container.addArrangedSubview(label)
        container.addArrangedSubview(view)
    }

    private func setupPhoneContainer() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 18, left: 12, bottom: 0, right: 12)
        phoneContainer = container
        container.backgroundColor = .white
        userDetailContainerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: userDetailContainerView.leadingAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: userDetailContainerView.trailingAnchor)
        let top = container.topAnchor.constraint(equalTo: nameContainer.bottomAnchor )

        NSLayoutConstraint.activate([leading, trailing, top])
        let label = getLabel(text: "Phone")
        let view = getLabelContentView(text: "+91 8209131942")

        container.addArrangedSubview(label)
        container.addArrangedSubview(view)
    }



    private func setupAddress() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 18, left: 12, bottom: 0, right: 12)
        addressContainer = container
        userDetailContainerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: userDetailContainerView.leadingAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: userDetailContainerView.trailingAnchor)
        let top = container.topAnchor.constraint(equalTo: phoneContainer.bottomAnchor)

        NSLayoutConstraint.activate([leading, trailing, top])
        let label = getLabel(text: "Current Address")
        let text = getLabelContentView(text: "Jagadamba Nagar, Ajmer road")

        container.addArrangedSubview(label)
        container.addArrangedSubview(text)
    }


    private func setupJoinedAndActive() {
        let container = UIStackView()
        joinedActiveContainer = container
        container.spacing = 20
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 18, left: 12, bottom: 0, right: 12)
        userDetailContainerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: userDetailContainerView.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: addressContainer.bottomAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: userDetailContainerView.trailingAnchor)
        NSLayoutConstraint.activate([leading, trailing, top])
        let joined = UIStackView()
        joined.spacing = 0
        joined.axis = .vertical
        container.addArrangedSubview(joined)
        let joinedLabel = getLabel(text: "Joined on")
        let joinedText = getLabelContentView(text: "20-07-2024")

        joined.addArrangedSubview(joinedLabel)
        joined.addArrangedSubview(joinedText)

        let active = UIStackView()
        active.spacing = 0
        active.axis = .vertical
        container.addArrangedSubview(active)
        let activeLabel = getLabel(text: "Current status")
        let activeText = getLabelContentView(text: "Active")

        active.addArrangedSubview(activeLabel)
        active.addArrangedSubview(activeText)
    }

    private func setupPlanStartAndExpiry() {
        let container = UIStackView()
        startExpiryContainer = container
        container.spacing = 20
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 18, left: 12, bottom: 0, right: 12)
        userDetailContainerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: userDetailContainerView.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: joinedActiveContainer.bottomAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: userDetailContainerView.trailingAnchor)
        NSLayoutConstraint.activate([leading, trailing, top])
        let joined = UIStackView()
        joined.spacing = 0
        joined.axis = .vertical
        container.addArrangedSubview(joined)
        let joinedLabel = getLabel(text: "Plan started on")
        let joinedText = getLabelContentView(text: "20-07-2024")
        joined.addArrangedSubview(joinedLabel)
        joined.addArrangedSubview(joinedText)
        let active = UIStackView()
        active.spacing = 0
        active.axis = .vertical
        container.addArrangedSubview(active)
        let activeLabel = getLabel(text: "Plan will expire on")
        let activeText = getLabelContentView(text: "20-12-2024")

        active.addArrangedSubview(activeLabel)
        active.addArrangedSubview(activeText)
    }

    private func setupPaymentDateAndAmount() {
        let container = UIStackView()
        paymentAmountDateContainer = container
        container.spacing = 20
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 18, left: 12, bottom: 0, right: 12)
        userDetailContainerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: userDetailContainerView.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: startExpiryContainer.bottomAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: userDetailContainerView.trailingAnchor)

        NSLayoutConstraint.activate([leading, trailing, top])
        let joined = UIStackView()
        joined.spacing = 0
        joined.axis = .vertical
        container.addArrangedSubview(joined)
        let joinedLabel = getLabel(text: "Last Payment Date")
        let joinedText = getLabelContentView(text: "20-07-2024")

        joined.addArrangedSubview(joinedLabel)
        joined.addArrangedSubview(joinedText)

        let active = UIStackView()
        active.spacing = 0
        active.axis = .vertical
        container.addArrangedSubview(active)
        let activeLabel = getLabel(text: "Payment Amount")
        let activeText = getLabelContentView(text: "₹2000")

        active.addArrangedSubview(activeLabel)
        active.addArrangedSubview(activeText)
        container.bottomAnchor.constraint(equalTo: userDetailContainerView.bottomAnchor, constant: -20).isActive = true
    }

    fileprivate func getLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }

    fileprivate func getLabelContentView(text: String) -> PlaceholderTextView {
        let tv = PlaceholderTextView()
        tv.text = text
        tv.textContainer.lineFragmentPadding = 0
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 4, right: 8)
        tv.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        tv.setTranslatesMask()

        let height = tv.heightAnchor.constraint(greaterThanOrEqualToConstant: 25)
        NSLayoutConstraint.activate([height])
        return tv
    }

    fileprivate func getSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.setTranslatesMask()
        let height = view.heightAnchor.constraint(equalToConstant: 1)
        NSLayoutConstraint.activate([height])
        return view
    }
}


extension LibraryUserDetailViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        guard let textView = textView as? PlaceholderTextView else { return }
        if(textView.text.isEmpty) {
            textView.showPlaceholder()
        } else if (textView.text.count == 1) {
            textView.hidePlaceholder()
        }
    }
}

