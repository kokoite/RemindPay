//
//  GymBreakupView.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 22/07/24.
//

import UIKit


final class GymBreakupView: UIView {


    private var titleLabel, totalAmountLabel, activeLabel, inactiveLabel, newJoinerLabel, planExpiringLabel: UILabel!
    private var containerView, detailContainerView: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func configure() {
        
    }

    private func setup() {
        setupContainer()
        setupTitleView()
        setupContainerStackView()
        setupActiveView()
        setupNewJoinerView()
        setupPlanExpiredView()
        setupPlanRenewedView()
        setupTotalAmountView()
    }

    private func setupContainer() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12
        containerView = container
        addSubview(container)
        container.backgroundColor = .white
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: trailingAnchor)
        let top  = container.topAnchor.constraint(equalTo: topAnchor)
        NSLayoutConstraint.activate([leading, trailing, top])
    }

    private func setupTitleView() {
        let label = UILabel()
        titleLabel = label
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        label.text = "Monthly breakup"
        containerView.addArrangedSubview(label)
    }

    private func setupContainerStackView() {
        let container = UIStackView()
        container.axis = .vertical
        detailContainerView = container
        container.spacing = 12
        container.backgroundColor = .white
        container.alignment = .center
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
        container.layer.shadowColor = UIColor.gray.cgColor
        container.layer.shadowOpacity = 0.7
        container.layer.shadowOffset = .init(width: 2, height: 2)
        container.layer.shadowRadius = 6
        containerView.addArrangedSubview(container)
        container.layer.cornerRadius = 6
        container.setTranslatesMask()
        let bottom = container.bottomAnchor.constraint(equalTo: bottomAnchor, constant:  -20)
        NSLayoutConstraint.activate([bottom])
    }

    private func setupActiveView() {
        let label = getLabel(placeholder: "Active users: ", text: "100")
        detailContainerView.addArrangedSubview(label)
    }

    private func setupNewJoinerView() {
        let label = getLabel(placeholder: "Newly Joined: ", text: "100")
        detailContainerView.addArrangedSubview(label)
    }

    private func setupPlanExpiredView() {
        let label = getLabel(placeholder: "Plan Expired: ", text: "100")
        detailContainerView.addArrangedSubview(label)
    }

    private func setupPlanRenewedView() {
        let label = getLabel(placeholder: "Plan renewed: ", text: "100")
        detailContainerView.addArrangedSubview(label)
    }

    private func setupTotalAmountView() {
        let label = UILabel()

        label.text = "Total amount recieved: ₹1000"
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        detailContainerView.addArrangedSubview(label)
    }



    private func getLabel(placeholder: String, text: String) -> UILabel {
        let label = UILabel()
        let placeholderAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 15, weight: .bold), .foregroundColor: UIColor.lightGray]
        let placeholderAttributed = NSAttributedString(string: placeholder, attributes: placeholderAttributes)

        let textAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
            .foregroundColor: UIColor.black
        ]
        let attributedText = NSAttributedString(string: text, attributes: textAttributes)
        let finalString = NSMutableAttributedString(attributedString: placeholderAttributed)
        finalString.append(attributedText)
        label.attributedText = finalString
        return label
    }



    private func getVerticalSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = .black
        view.setTranslatesMask()
        let width = view.widthAnchor.constraint(equalToConstant: 1)
        let height = view.heightAnchor.constraint(equalToConstant: 20)
        NSLayoutConstraint.activate([height, width])
        return view
    }

    /*
     Monthly ->
     amount
     plan expired, plan expiring
     plan renew, new joiners


     Yearly ->
     Active users, Inactive
     New joiners
     Total amount


     Total ->
     Active users, Inactive
     Total amount
     */
}
