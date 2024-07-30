//
//  SearchView.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 16/07/24.
//

import UIKit

protocol SearchViewDelegate: AnyObject {
    func didClickOnSearchIcon(text: String)
    func didClickOnFilterIcon()
    func onSearchViewTextChange(text: String)
}

final class SearchView: UIView {
    private var containerView: UIStackView!
    private var searchIcon, filterIcon: UIImageView!
    private var textView: UITextField!
    var delegate: SearchViewDelegate?

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

    @objc func searchIconClicked() {
        delegate?.didClickOnSearchIcon(text: textView.text ?? "")
    }

    @objc func searchTextChanged() {
        delegate?.onSearchViewTextChange(text: textView.text ?? "")
    }

    @objc func filterIconClicked() {
        delegate?.didClickOnFilterIcon()
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
        container.backgroundColor = .white
        addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: leadingAnchor)
        let trailing = container.trailingAnchor.constraint(equalTo: trailingAnchor)
        let top = container.topAnchor.constraint(equalTo: topAnchor)
        let bottom = container.bottomAnchor.constraint(equalTo: bottomAnchor)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
        container.clipsToBounds = true
        container.layer.cornerRadius = 8
        container.spacing = 12
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
    }

    private func setupSearchIcon() {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(searchIconClicked))
        image.addGestureRecognizer(tapGesture)
        searchIcon = image
        containerView.addArrangedSubview(image)
        image.image = UIImage(systemName: "magnifyingglass")
        image.tintColor = .gray
        image.contentMode = .center
        image.setTranslatesMask()
        let width = image.widthAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([ width])
    }

    private func setupFilterIcon() {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(filterIconClicked))
        image.addGestureRecognizer(tapGesture)
        filterIcon = image
        containerView.addArrangedSubview(image)
        image.image = UIImage(systemName: "line.3.horizontal.decrease.circle")
        image.tintColor = .gray
        image.contentMode = .center
        image.setTranslatesMask()
        let width = image.widthAnchor.constraint(equalToConstant: 40)
        NSLayoutConstraint.activate([width])
    }

    private func setupTextView() {
        let text = UITextField()
        textView = text
        text.setTranslatesMask()
        text.heightAnchor.constraint(equalToConstant: 40).isActive = true
        text.font = UIFont.systemFont(ofSize: 20)
        text.placeholder = "Search for users"
        text.autocapitalizationType = .sentences
        text.autocorrectionType = .no
        containerView.addArrangedSubview(text)
    }
}

extension SearchView: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.onSearchViewTextChange(text: textField.text ?? "")
    }
}
