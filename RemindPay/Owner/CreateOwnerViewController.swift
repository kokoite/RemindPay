//
//  CreateOwnerViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 31/07/24.
//

import UIKit
import AVFoundation
import PhotosUI

final class CreateOwnerViewController: UIViewController {

    private var containerScrollView: UIScrollView!
    private var containerView: UIView!
    private var imageView: UIImageView!
    private var createButton: UIButton!

    private var nameView, phoneView, addressView: PlaceholderTextView!
    private var detailContainerView: UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    @objc func cameraClicked() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let controller = PHPickerViewController(configuration: config)
        controller.modalPresentationStyle = .fullScreen
        controller.modalTransitionStyle = .coverVertical
        controller.delegate = self
        present(controller, animated: true)
    }

    @objc func createUserClicked() {
        //
    }

    private func setup() {
        setupScrollView()
        setupContainer()
        setupImageView()
        setupDetailContainer()
        setupNameView()
        setupPhoneView()
        setupEmailContainer()
        setupMembershipTypeChargesContainer()
        setupCreateButton()
    }

    private func setupScrollView() {
        let scrollView = UIScrollView()
        scrollView.delegate = self
        scrollView.backgroundColor = .white
        containerScrollView = scrollView
        view.addSubview(scrollView)
        scrollView.setTranslatesMask()
        scrollView.pinToEdges(in: view)
        scrollView.showsVerticalScrollIndicator = false
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        containerScrollView.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: containerScrollView)
        container.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
        container.backgroundColor = .white
    }


    private func setupImageView() {
        let image = UIImageView()
        imageView = image
        image.isUserInteractionEnabled = true
        image.image = UIImage(systemName: "photo.circle.fill")
        image.contentMode = .scaleAspectFill
        image.tintColor = .black
        image.backgroundColor = .white
        containerView.addSubview(image)
        image.setTranslatesMask()
        let centerX = image.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let top = image.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 10)
        let height = image.heightAnchor.constraint(equalToConstant: 150)
        let width = image.widthAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([centerX, top, height ,width])
        image.layer.cornerRadius = 12
        image.clipsToBounds = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(cameraClicked))
        image.addGestureRecognizer(gesture)
    }

    private func setupDetailContainer() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 30
        container.backgroundColor = .white
        detailContainerView = container
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let top = container.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        NSLayoutConstraint.activate([leading, trailing, top])
    }

    private func setupNameView() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        let label = getLabel(text: "Name")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "Pranjal Agarwal")
        container.addArrangedSubview(tf)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        detailContainerView.addArrangedSubview(container)
    }

    private func setupEmailContainer() {
        let container = UIStackView()
        container.spacing = 0
        detailContainerView.addArrangedSubview(container)
        container.axis = .vertical
        let label = getLabel(text: "Email")
        let tv = getTextView(text: "doejohn@gmail.com")
        let separator = getSeparator()
        container.addArrangedSubview(label)
        container.addArrangedSubview(tv)
        container.addArrangedSubview(separator)
    }

    private func setupPhoneView() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        let label = getLabel(text: "Phone")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "+91 820 91375546")
        container.addArrangedSubview(tf)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        detailContainerView.addArrangedSubview(container)
    }

    private func setupMembershipTypeChargesContainer() {
        let container = UIStackView()
        container.spacing = 20
        detailContainerView.addArrangedSubview(container)

        let sContainer = UIStackView()
        sContainer.axis = .vertical
        let label1 = getLabel(text: "Membership Type")
        let tv1 = getTextView(text: "Free")
        let sep1 = getSeparator()
        sContainer.addArrangedSubview(label1)
        sContainer.addArrangedSubview(tv1)
        sContainer.addArrangedSubview(sep1)

        let eContainer = UIStackView()
        eContainer.axis = .vertical
        let label2 = getLabel(text: "Memberhship charges")
        let tv2 = getTextView(text: "₹0")
        let sep2 = getSeparator()
        eContainer.addArrangedSubview(label2)
        eContainer.addArrangedSubview(tv2)
        eContainer.addArrangedSubview(sep2)

        container.addArrangedSubview(sContainer)
        container.addArrangedSubview(eContainer)
    }

    private func setupCreateButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        let button = UIButton(configuration: config)
        createButton = button
        button.tintColor = .black
        button.setTitle("Create User", for: .normal)
        button.addTarget(self, action: #selector(createUserClicked), for: .touchUpInside)
        containerView.addSubview(button)
        button.setTranslatesMask()
        let centerX = button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let top = button.topAnchor.constraint(equalTo: detailContainerView.bottomAnchor, constant: 30)
        let bottom = button.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        let width = button.widthAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([centerX, bottom, width, top])
    }

    private func getLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }

    private func getSeparator() -> UIView {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.setTranslatesMask()

        let height = separator.heightAnchor.constraint(equalToConstant: 1)
        NSLayoutConstraint.activate([height])
        return separator
    }

    private func getTextView(text: String) -> PlaceholderTextView {
        let tv = PlaceholderTextView()
        tv.placeholderText = text
        tv.delegate = self
        tv.isScrollEnabled = false
//        tv.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 4, right: 8)
        tv.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        tv.setTranslatesMask()
        let height = tv.heightAnchor.constraint(greaterThanOrEqualToConstant: 25)
        NSLayoutConstraint.activate([height])
        return tv
    }

    deinit {
        print("\(self) \(#function)")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y > -87) {
            navigationController?.navigationBar.isHidden = true
        } else {
            navigationController?.navigationBar.isHidden = false
        }
    }
}

extension CreateOwnerViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        defer {
            dismiss(animated: true)
        }
        guard let provider = results.first?.itemProvider else { return }
        if(provider.canLoadObject(ofClass: UIImage.self)) {
            provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self, let image = image as? UIImage, error == nil else { return }
                    self.imageView.image = image
                }
            }
        }
    }



}


extension CreateOwnerViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        guard let textView = textView as? PlaceholderTextView else { return }
        if(textView.text.isEmpty) {
            textView.showPlaceholder()
        } else if (textView.text.count == 1) {
            textView.hidePlaceholder()
        }
    }
}
