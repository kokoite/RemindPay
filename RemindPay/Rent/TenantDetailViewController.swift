//
//  TenantDetailViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 28/07/24.
//

//
//  UserDetailViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 18/07/24.
//

import UIKit
import SwiftUI

final class TenantDetailViewController: UIViewController {

    fileprivate var containerScrollView: UIScrollView!
    fileprivate var carouselView: CarouselView!
    fileprivate var containerView, separatorView, carouselContainer, userDetailContainerView: UIView!
    fileprivate var nameView, phoneView, gymJoined, planStarted, planExpiry, addressView, diseaseView, weightView, heightView, bmiView, isActiveView, paymentView
    : UILabel!

    fileprivate var nameContainer, phoneContainer, hwContainer, diseaseContainer, addressContainer, startExpiryContainer, paymentAmountDateContainer, joinedActiveContainer: UIStackView!

    fileprivate var chartContainer: UIStackView!
    private var editButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cardBackground
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backButtonTitle = "No back"
        navigationController?.navigationBar.tintColor = .black
    }

    func configure() {

    }

    @objc func editButtonClicked() {
        print("Edit button clicked")
    }

    private func setup() {
        setupScrollContainer()
        setupContainer()
        setupCarouselContainer()
        setupCarousel()
        setupUserDetailContainer()
        setupUserDetails()
        setupEditButton()
    }

    private func setupScrollContainer() {
        let container = UIScrollView()
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

    private func setupCarouselContainer() {
        let container = UIView()
        carouselContainer = container
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

    private func setupCarousel() {
        let container = CarouselView()
        carouselView = container
        container.delegate = self
        carouselContainer.addSubview(container)
        container.setTranslatesMask()
        let centerX = container.centerXAnchor.constraint(equalTo: carouselContainer.centerXAnchor)
        let top = container.topAnchor.constraint(equalTo: carouselContainer.topAnchor, constant: 12)
        let width = container.widthAnchor.constraint(equalToConstant: view.bounds.width*0.8 - 40)
        let height = container.heightAnchor.constraint(equalToConstant: 300)
        let bottom = container.bottomAnchor.constraint(equalTo: carouselContainer.bottomAnchor, constant: -12)
        NSLayoutConstraint.activate([centerX, top, height, width, bottom])
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

extension TenantDetailViewController: CarouselViewDelegate {
    func didSelectItemAtIndexPath(indexPath: IndexPath) {
        print("item selected at index path \(indexPath)")
    }

    func didScrollToItemAtIndexPath(indexPath: IndexPath) {
    }

    func numberOfItemsInCarousel() -> Int {
        return 10
    }
}

// Tenant Detail Container
extension TenantDetailViewController {

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
        let top = container.topAnchor.constraint(equalTo: carouselContainer.bottomAnchor, constant: 20)
        let bottom = container.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }

    fileprivate func setupUserDetails() {
        setupNameContainer()
        setupPhoneContainer()
        setupAdvanceAndSecurityContainer()
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

    private func setupAdvanceAndSecurityContainer() {
        let container = UIStackView()
        hwContainer = container
        container.spacing = 20
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 18, left: 12, bottom: 0, right: 12)
        userDetailContainerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: userDetailContainerView.leadingAnchor)
        let top = container.topAnchor.constraint(equalTo: phoneContainer.bottomAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: userDetailContainerView.trailingAnchor)
        NSLayoutConstraint.activate([leading, trailing, top])
        let weight = UIStackView()
        weight.spacing = 0
        weight.axis = .vertical
        container.addArrangedSubview(weight)
        let weightLabel = getLabel(text: "Advance amount paid ")
        let weightText = getLabelContentView(text: "₹20000")

        weight.addArrangedSubview(weightLabel)
        weight.addArrangedSubview(weightText)

        let height = UIStackView()
        height.spacing = 0
        height.axis = .vertical
        container.addArrangedSubview(height)
        let heightLabel = getLabel(text: "Security amount paid")
        let heightText = getLabelContentView(text: "₹18000")

        height.addArrangedSubview(heightLabel)
        height.addArrangedSubview(heightText)
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
        let top = container.topAnchor.constraint(equalTo: hwContainer.bottomAnchor)

        NSLayoutConstraint.activate([leading, trailing, top])
        let label = getLabel(text: "Current Address")
        let text = getLabelContentView(text: "Manas Hospital")

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
        let joinedLabel = getLabel(text: "Started living from")
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
        let joinedLabel = getLabel(text: "Rent started date")
        let joinedText = getLabelContentView(text: "20-07-2024")
        joined.addArrangedSubview(joinedLabel)
        joined.addArrangedSubview(joinedText)
        let active = UIStackView()
        active.spacing = 0
        active.axis = .vertical
        container.addArrangedSubview(active)
        let activeLabel = getLabel(text: "Rent expiry Date")
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
