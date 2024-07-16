//
//  SearchView.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//

import UIKit

final class SearchView: UIView {
    private var containerView: UIStackView!
    private var searchIcon, filterIcon: UIImageView!
    private var textView: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }


    // MARK :- Public functions

    func configure() {

    }


    // MARK :- Private functions

    private func setup() {
        clipsToBounds = true
        setupContainer()
        setupSearchIcon()
        setupTextView()
        setupFilterIcon()
    }
    
    private func setupContainer() {
        let container = UIStackView()
        containerView = container
        addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: trailingAnchor)
        let top = container.topAnchor.constraint(equalTo: topAnchor)
        NSLayoutConstraint.activate([leading, trailing, top])
        container.backgroundColor = .white
        container.clipsToBounds = true
        container.layer.borderWidth = 1
        container.layer.borderColor = UIColor.gray.cgColor
        container.layer.cornerRadius = 15
        container.spacing = 12
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }

    private func setupSearchIcon() {
        let image = UIImageView()
        searchIcon = image
        containerView.addArrangedSubview(image)
        image.image = UIImage(systemName: "magnifyingglass")
        image.tintColor = .gray
        image.contentMode = .center
        image.setTranslatesMask()
        let height = image.heightAnchor.constraint(equalToConstant: 40)
        let width = image.widthAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([height, width])
    }

    private func setupFilterIcon() {
        let image = UIImageView()
        filterIcon = image
        containerView.addArrangedSubview(image)
        image.image = UIImage(systemName: "line.3.horizontal.decrease.circle")
        image.tintColor = .gray
        image.contentMode = .center
        image.setTranslatesMask()
        let height = image.heightAnchor.constraint(equalToConstant: 40)
        let width = image.widthAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([height, width])
    }

    private func setupTextView() {
        let text = UITextField()
        textView = text
        text.font = UIFont.systemFont(ofSize: 20)
        text.placeholder = "Search for users"
        text.autocapitalizationType = .sentences
        text.autocorrectionType = .no
        containerView.addArrangedSubview(text)
    }
}
