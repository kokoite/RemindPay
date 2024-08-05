//
//  RentUserCollectionViewCell.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 05/08/24.
//

import Foundation
import UIKit

final class RentUserCollectionViewCell: UICollectionViewCell {

    private var containerView: UIView!
    private var imageView: UIImageView!
    private var titleView: UILabel!
    private var subtitleView: UILabel!
    private var joiningDateView: UILabel!
    private var expiryDateView: UILabel!
    private var userDetailContainer: UIStackView!


    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK :-  Public methods
    func configure(using vm: Rent.Refresh.Response.ViewModel) {

//        DispatchQueue.main.async {
//            let image = try? getImageFrom(fileName: vm.profileImage)
//            self.imageView.image = image
//        }
//
//        titleView.text = vm.name
//        subtitleView.text = vm.phone
//        expiryDateView.text = vm.expiryDate
    }

    private func setup() {
        setupContainer()
        setupImage()
        setupDetailContainer()
        makeSkeletonable()
    }

    private func makeSkeletonable() {
        [self, contentView,containerView,userDetailContainer, imageView, titleView, subtitleView, expiryDateView].forEach { view in
            view?.isSkeletonable = true
        }
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

    private func setupImage() {
        let image = UIImageView()
        containerView.addSubview(image)
        imageView = image
//        image.image = UIImage(named: "happyFace")
        image.clipsToBounds = true
        image.backgroundColor = .white
        image.layer.cornerRadius = 30
        image.contentMode = .scaleAspectFill
        image.setTranslatesMask()
        let top = image.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5)
        let bottom = image.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -5)
        let width = image.widthAnchor.constraint(equalToConstant: 150)
        let leading = image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        [top, bottom, width, leading].forEach { cons in
            cons.isActive = true
        }
    }

    private func setupDetailContainer() {
        let container = UIStackView()
        userDetailContainer = container
        container.axis = .vertical
        container.spacing = 12
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        let centerY = container.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        NSLayoutConstraint.activate([leading, trailing, centerY])
        let name = getLabel(text: "Pranjal Agarwal")
        let phone = getLabel(text: "8209139142")
        let expiry = getLabel(text: "20-08-2024")
        titleView = name
        subtitleView = phone
        expiryDateView = expiry
        container.addArrangedSubview(name)
        container.addArrangedSubview(phone)
        container.addArrangedSubview(expiry)
    }

    private func getLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }
}

