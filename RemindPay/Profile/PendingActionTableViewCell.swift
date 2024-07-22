//
//  PendingActionTableViewCell.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 22/07/24.
//

import UIKit

struct PendingAction {
    let title, subtitle: String
    let imageName: String
}

final class PendingActionTableViewCell: UITableViewCell {

    private var containerView: UIView!
    private var iconView: UIImageView!
    private var titleView, subtitleView: UILabel!
    private var actionButton: UIButton!


    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    func configure() {

    }

    private func setup() {
        contentView.backgroundColor = .systemPink
        setupContainer()
        setupImageView()
        setupTitleView()
        setupSubtitleView()
        setupButton()
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        container.backgroundColor = .white
        contentView.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: contentView)
    }

    private func setupImageView() {
        let image = UIImageView()
        iconView = image
        image.image = UIImage(systemName: "exclamationmark.bubble.fill")
        image.tintColor = .black
        image.backgroundColor = .white
        containerView.addSubview(image)
        image.setTranslatesMask()
        let leading = image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let height = image.heightAnchor.constraint(equalToConstant: 20)
        let width = image.widthAnchor.constraint(equalToConstant: 20)
        let top = image.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12)
        NSLayoutConstraint.activate([leading, top, height, width])
    }

    private func setupTitleView() {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 0
        titleView = label
        label.text = "Gym membership payment"
        containerView.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 10)
        let top = label.topAnchor.constraint(equalTo: iconView.topAnchor)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupSubtitleView() {
        let label = UILabel()
        subtitleView = label
        containerView.addSubview(label)
        label.numberOfLines = 0
        label.text = "Heyy you forgot to pay for your last month membership"
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: iconView.leadingAnchor)
        let top = label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 12)
        let trailing = label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        NSLayoutConstraint.activate([leading, top, trailing])
    }

    private func setupButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        let button = UIButton(configuration: config)
        containerView.addSubview(button)
        button.tintColor = .black
        actionButton = button
        button.setTitle("Done", for: .normal)
        button.setTranslatesMask()
        let leading = button.leadingAnchor.constraint(equalTo: subtitleView.leadingAnchor)
        let top = button.topAnchor.constraint(equalTo: subtitleView.bottomAnchor, constant: 12)
        let bottom = button.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        NSLayoutConstraint.activate([leading, top, bottom])
    }
}
