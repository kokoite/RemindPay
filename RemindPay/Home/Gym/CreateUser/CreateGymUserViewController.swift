//
//  CreateGymUserViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 19/07/24.
//

import UIKit
import AVFoundation

final class CreateGymUserViewController: UIViewController, UINavigationControllerDelegate {

    fileprivate var containerScrollView: UIScrollView!
    fileprivate var containerView: UIView!
    fileprivate var imageView: UIImageView!
    fileprivate var createButton: UIButton!
    fileprivate var detailContainerView: UIStackView!
    fileprivate var nameView, phoneView, weightView,
                heightView,
                paymentView,
                addressView, diseaseView
    : PlaceholderTextView!
    fileprivate var joinedView, expiryView: UILabel!
    private var imagePicker: UIImagePickerController


    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        imagePicker = UIImagePickerController()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .white
        navigationItem.standardAppearance = appearance
        navigationItem.scrollEdgeAppearance = appearance
        navigationItem.compactAppearance = appearance
        navigationItem.compactScrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .black
    }

    @objc func expiryDateClicked() {
        let controller = DatePickerController()
        addChild(controller)
        containerView.addSubview(controller.view)
        controller.delegate = self
        controller.view.setTranslatesMask()
        controller.view.pinToEdges(in: containerView)
        controller.didMove(toParent: self)
    }

    @objc func createButtonClicked() {

    }

    @objc func cameraClicked() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            showAlert(title: "Camera not found", subtitle: "Sorry you won't be able to add users. We are not able to found camera on your device")
            return
        }
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if(status == .notDetermined) {
            requestPermission()
        } else if(status == .authorized) {
            presentCamera()
        } else {
            print(status)
            showPermissionDeniedAlert()
        }
    }

    private func requestPermission() {
        AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
            guard let self else { return }
            DispatchQueue.main.async {
                granted ? self.presentCamera(): self.showPermissionDeniedAlert()
            }
        }
    }

    private func presentCamera() {
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }

    private func showPermissionDeniedAlert() {
        showAlert(title: "Permssion denied", subtitle: "Permission denined, Please grant permission in order to use this feature")
    }

    private func showAlert(title: String, subtitle: String) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }

    private func setup() {
        setupScrollView()
        setupContainer()
        setupImageView()
        setupDetailContainer()
        setupNameView()
        setupPhoneView()
        setupWeightHeightContainer()
        setupAddressView()
        setupExistingDiseaseView()
        setupJoiningExpiryContainer()
        setupPaymentView()
        setupCreateButton()
    }
}

extension CreateGymUserViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            imageView.image = editedImage
        } else if let originalImage = info[.originalImage] as? UIImage {
            imageView.image = originalImage
        }
        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}


extension CreateGymUserViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        guard let textView = textView as? PlaceholderTextView else { return }
        if(textView.text.isEmpty) {
            textView.showPlaceholder()
        } else if (textView.text.count == 1) {
            textView.hidePlaceholder()
        }
    }
}

extension CreateGymUserViewController: DatePickerDelegate {
    func didSelect(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        expiryView.text = formatter.string(from: date)
    }

    func didDismiss(date: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        expiryView.text = formatter.string(from: date)
    }
}


// UI related
extension CreateGymUserViewController {

    fileprivate func setupScrollView() {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        containerScrollView = scrollView
        view.addSubview(scrollView)
        scrollView.setTranslatesMask()
        scrollView.pinToEdges(in: view)
        scrollView.showsVerticalScrollIndicator = false
    }

    fileprivate func setupContainer() {
        let container = UIView()
        containerView = container
        containerScrollView.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: containerScrollView)
        container.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
        container.backgroundColor = .white
    }


    fileprivate func setupImageView() {
        let image = UIImageView()
        imageView = image
        image.isUserInteractionEnabled = true
        image.image = UIImage(systemName: "camera.circle.fill")
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        image.backgroundColor = .white
        let gesture = UITapGestureRecognizer(target: self, action: #selector(cameraClicked))
        image.addGestureRecognizer(gesture)
        containerView.addSubview(image)
        image.setTranslatesMask()
        let centerX = image.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let top = image.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 10)
        let height = image.heightAnchor.constraint(equalToConstant: 150)
        let width = image.widthAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([centerX, top, height ,width])
        image.layer.cornerRadius = 75
        image.clipsToBounds = true
    }

    fileprivate func setupDetailContainer() {
        let container = UIStackView()
        detailContainerView = container
        container.spacing = 30
        container.axis = .vertical
        container.backgroundColor = .white
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, trailing, top])
    }

    fileprivate func setupNameView() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        let label = getLabel(text: "Name")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "Pranjal Agarwal")
        nameView = tf
        container.addArrangedSubview(tf)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        detailContainerView.addArrangedSubview(container)
    }

    fileprivate func setupPhoneView() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        let label = getLabel(text: "Phone")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "8291375546")
        phoneView = tf
        container.addArrangedSubview(tf)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        detailContainerView.addArrangedSubview(container)
    }

    fileprivate func setupWeightHeightContainer() {
        let container = UIStackView()
        container.spacing = 20
        detailContainerView.addArrangedSubview(container)

        let sContainer = UIStackView()
        sContainer.axis = .vertical
        let label1 = getLabel(text: "Weight in kgs")
        label1.numberOfLines = 0
        let tv1 = getTextView(text: "80")
        weightView = tv1
        let sep1 = getSeparator()
        sContainer.addArrangedSubview(label1)
        sContainer.addArrangedSubview(tv1)
        sContainer.addArrangedSubview(sep1)

        let eContainer = UIStackView()
        eContainer.axis = .vertical
        let label2 = getLabel(text: "Height in cms")
        let tv2 = getTextView(text: "180")
        heightView = tv2
        let sep2 = getSeparator()
        eContainer.addArrangedSubview(label2)
        eContainer.addArrangedSubview(tv2)
        eContainer.addArrangedSubview(sep2)

        container.addArrangedSubview(sContainer)
        container.addArrangedSubview(eContainer)
    }

    fileprivate func setupAddressView() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        let label = getLabel(text: "Current Address")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "Manas hospital")
        addressView = tf
        container.addArrangedSubview(tf)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        detailContainerView.addArrangedSubview(container)
    }

    fileprivate func setupExistingDiseaseView() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        let label = getLabel(text: "Existing disease")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "Fracture in left leg")
        diseaseView = tf
        container.addArrangedSubview(tf)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        detailContainerView.addArrangedSubview(container)
    }

    fileprivate func setupJoiningExpiryContainer() {
        let container = UIStackView()
        container.spacing = 20
        detailContainerView.addArrangedSubview(container)

        let sContainer = UIStackView()
        sContainer.axis = .vertical
        sContainer.spacing = 8
        let label1 = getLabel(text: "Plan Starting date")
        label1.numberOfLines = 0
        let date = getTodaysDate()
        let tv1 = getLabel(text: date)
        joinedView = tv1
        tv1.textColor = .gray
        tv1.font = UIFont.systemFont(ofSize: 16)
        let sep1 = getSeparator()
        sContainer.addArrangedSubview(label1)
        sContainer.addArrangedSubview(tv1)
        sContainer.addArrangedSubview(sep1)

        let eContainer = UIStackView()
        eContainer.axis = .vertical
        eContainer.spacing = 8
        let label2 = getLabel(text: "Plan expiry date")
        let tv2 = getLabel(text: "31-07-2024")
        expiryView = tv2
        tv2.textColor = .gray
        tv2.font = UIFont.systemFont(ofSize: 16)
        tv2.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(expiryDateClicked))
        tv2.addGestureRecognizer(tapGesture)
        let sep2 = getSeparator()
        eContainer.addArrangedSubview(label2)
        eContainer.addArrangedSubview(tv2)
        eContainer.addArrangedSubview(sep2)

        container.addArrangedSubview(sContainer)
        container.addArrangedSubview(eContainer)
    }

    fileprivate func setupPaymentView() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        let label = getLabel(text: "Payment amount")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "2000")
        paymentView = tf
        container.addArrangedSubview(tf)
        let sep = getSeparator()
        container.addArrangedSubview(sep)
        detailContainerView.addArrangedSubview(container)
    }

    fileprivate func setupCreateButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 12)
        let button = UIButton(configuration: config)
        createButton = button
        button.tintColor = .black
        button.setTitle("Create User", for: .normal)
        button.addTarget(self, action: #selector(createButtonClicked), for: .touchUpInside)
        containerView.addSubview(button)
        button.setTranslatesMask()
        let centerX = button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let top = button.topAnchor.constraint(equalTo: detailContainerView.bottomAnchor, constant: 40)
        let bottom = button.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        let width = button.widthAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([centerX, bottom, width, top])
    }

    fileprivate func getLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }

    fileprivate func getSeparator(isFullLength: Bool = true) -> UIView {
        let separator = UIView()
        separator.backgroundColor = .lightGray
        separator.setTranslatesMask()
        let height = separator.heightAnchor.constraint(equalToConstant: 1)
        NSLayoutConstraint.activate([height])
        return separator
    }

    fileprivate func getTextView(text: String, isSeparatorFullLength: Bool = true) -> PlaceholderTextView {
        let tv = PlaceholderTextView()
        tv.placeholderText = text
        tv.delegate = self
        tv.isScrollEnabled = false
        tv.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        tv.setTranslatesMask()
        let height = tv.heightAnchor.constraint(greaterThanOrEqualToConstant: 25)
        NSLayoutConstraint.activate([height])
        return tv
    }
}
