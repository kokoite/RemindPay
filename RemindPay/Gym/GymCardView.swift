//
//  GymCardView.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//
import UIKit

final class GymCardView: UICollectionViewCell {

    private var containerView: UIView? = nil
    private var imageView: UIImageView? = nil
    private var titleView: UILabel? = nil
    private var subtitleView: UILabel? = nil
    private var startingDateView: UILabel? = nil
    private var endingDateView: UILabel? = nil

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
        self.containerView = container
    }

    private func setupImage() {
        guard let container = containerView else { return }
        let image = UIImageView()
        container.addSubview(image)
        image.setTranslatesMask()
        let height = image.heightAnchor.constraint(equalToConstant: 100)
        let width = image.widthAnchor.constraint(equalToConstant: 100)
        let leading = image.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 20)
        let centerY = image.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        NSLayoutConstraint.activate([height, width, leading, centerY])
        image.layer.cornerRadius = 50
        image.clipsToBounds = true
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.gray.cgColor
    }
}
