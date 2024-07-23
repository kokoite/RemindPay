//
//  GymBreakupView.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 22/07/24.
//

import UIKit


final class GymBreakupView: UIView {


    private var containerView: UIView!
    private var titleLabel, totalAmountLabel, activeLabel, inactiveLabel, newJoinerLabel, planExpiringLabel: UILabel!
    private var userActivityContainer, userDataContainer, userExpiryContainer: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        setupContainer()
        setupTitleView()
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        addSubview(container)
        container.backgroundColor = .white
        container.setTranslatesMask()
        container.pinToEdges(in: self)
    }

    private func setupTitleView() {
        let label = UILabel()
        titleLabel = label
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        label.text = "Monthly breakup"
        containerView.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let top = label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupTotalAmount() {
        let label = getLabel(placeholder: "Total Amount earned: ", text: "10000")
        containerView.addSubview(label)
        label.setTranslatesMask()
        let centerX = label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let top = label.topAnchor.constraint(equalTo: userExpiryContainer.bottomAnchor, constant: 20)
        NSLayoutConstraint.activate([centerX, top])
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

    private func setupTotalAmountView() {
        let label = UILabel()
        totalAmountLabel = label
        label.text = "Total amount: 20000"
        containerView.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        let top = label.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12)
        NSLayoutConstraint.activate([leading, top])
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
