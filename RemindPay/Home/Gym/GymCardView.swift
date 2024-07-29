//
//  GymCardView.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//
import UIKit

final class GymCardView: UICollectionViewCell {

    private var containerView, userDetailContainer: UIView!
    private var imageView: UIImageView!
    private var titleView: UILabel!
    private var subtitleView: UILabel!
    private var joiningDateView: UILabel!
    private var expiryDateView: UILabel!


    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK :-  Public methods
    func configure() {

    }

    private func setup() {
        setupContainer()
        setupImage()
        setupName()
        setupPhone()
        setupJoining()
        setupExpiry()
    }

    private func setupContainer() {
        let container = UIView()
        contentView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12)
        let trailing = container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12)
        let top = container.topAnchor.constraint(equalTo: contentView.topAnchor)
        let bottom = container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
        container.backgroundColor = .cardBackground
        container.layer.cornerRadius = 20
        containerView = container
    }

    private func setupName() {
        let name = UILabel()
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 20)
        name.text = "Pranjal Agarwal"
        titleView = name
        containerView.addSubview(name)
        name.setTranslatesMask()
        let leading = name.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 20)
        let top = name.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 12)
        let trailing = name.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        NSLayoutConstraint.activate([leading, trailing, top])

    }

    private func setupPhone() {
        let phone = UILabel()
        phone.textColor = .black
        phone.text = "9212433690"
        subtitleView = phone
        containerView.addSubview(phone)
        phone.setTranslatesMask()

        let leading = phone.leadingAnchor.constraint(equalTo: titleView.leadingAnchor)
        let top = phone.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 12)
        let trailing = phone.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        NSLayoutConstraint.activate([leading, trailing, top])
    }

    private func setupJoining() {
        let label = UILabel()
        label.textColor = .black
        containerView.addSubview(label)
        joiningDateView = label
        label.text = "J.Date - 16-07-2024"
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: titleView.leadingAnchor)
        let top = label.topAnchor.constraint(equalTo: subtitleView.bottomAnchor, constant: 12)
        let trailing = label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        NSLayoutConstraint.activate([leading, top, trailing])
    }

    private func setupExpiry() {
        let label = UILabel()
        label.textColor = .black
        containerView.addSubview(label)
        expiryDateView = label
        label.text = "E.Date - 16-09-2024"
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: titleView.leadingAnchor)
        let top = label.topAnchor.constraint(equalTo: joiningDateView.bottomAnchor, constant: 12)
        let trailing = label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        NSLayoutConstraint.activate([leading, top, trailing])
    }

    private func setupImage() {
        let image = UIImageView()
        containerView.addSubview(image)
        imageView = image
        image.image = UIImage(named: "happyFace")
        image.clipsToBounds = true
        image.backgroundColor = .red
        image.layer.cornerRadius = 30
        image.contentMode = .scaleAspectFit
        image.setTranslatesMask()
        let centerY = image.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        let height = image.heightAnchor.constraint(equalToConstant: 150)
        let width = image.widthAnchor.constraint(equalToConstant: 150)
        let leading = image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        NSLayoutConstraint.activate([centerY, height, width, leading])
    }
}
