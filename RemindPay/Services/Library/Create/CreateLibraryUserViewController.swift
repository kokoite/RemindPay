//
//  CreateLibraryUserViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 05/08/24.
//

import UIKit
import PhotosUI


protocol CreateLibraryUserDisplayLogic: AnyObject {
    func displayCreateLibraryUser(response: Library.Create.ViewModel)
}

final class CreateLibraryUserViewController: UIViewController {

    private var containerScrollView: UIScrollView!
    private var containerView: UIView!
    private var imageView: UIImageView!
    private var createButton: UIButton!
    private var userImage: String!
    private var userSelectedImage: UIImage?
    private var userSelectedImageName: String?

    private var nameView, phoneView, ageView, amountView, addressView: PlaceholderTextView!
    private var  startingView, expiryView: UILabel!
    private var detailContainerView: UIStackView!
    private var cameraController: PHPickerViewController!
    private var interactor: CreateLibraryUserBusinessLogic?
    private let manager = ImageManager.instance

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNotificationObservers()
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

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    @objc func cameraClicked() {
        present(cameraController, animated: true)
    }


    @objc func createButtonClicked() {
        guard let userSelectedImage else {
            // show error bottom sheet
            return
        }
        manager.singleImageDelegate = self
        manager.saveImageToDocuments(image: userSelectedImage)
    }

    @objc func selectDate(_ sender: UITapGestureRecognizer) {
        guard let label = sender.view as? UILabel else {
            print("No label")
            return
        }
        let controller = DatePickerController()
        controller.modalPresentationStyle = .custom
        let delegate = DateControllerTransitionDelegate()
        controller.transitioningDelegate = delegate
        controller.action = { (date) in
            label.text = date
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.textColor = .black
        }
        present(controller, animated: true)
    }

    @objc func dismissKeyBoard() {
        view.endEditing(true)
    }

    @objc func keyboardAppears(_ notification: Notification) {
        
        guard let userInfo = notification.userInfo , let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
            print("Something wrong")
            return
        }
        var contentInset = containerScrollView.contentInset
        contentInset.bottom = keyboardFrame.height
        containerScrollView.contentInset = contentInset
    }

    @objc func keyboardDisappears(_ notification: Notification) {
        var contentInset = containerScrollView.contentInset
        contentInset.bottom = 0
        containerScrollView.contentInset = contentInset
    }

    private func initialize() {
        var cameraConfig = PHPickerConfiguration()
        cameraConfig.filter = .images
        cameraConfig.selectionLimit = 1
        cameraController = PHPickerViewController(configuration: cameraConfig)
        cameraController.modalPresentationStyle = .fullScreen
        cameraController.delegate = self


        let interactor = CreateLibraryUserInteractor()
        interactor.viewController = self
        self.interactor = interactor
    }

    private func setup() {
        setupScrollView()
        setupContainer()
        setupImageView()
        setupDetailContainer()
        setupNameView()
        setupPhoneView()
        setupAddressView()
        setupRentStartEndContainer()
        setupRentView()
        setupCreateButton()
    }

    private func setupNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppears), name: UIResponder.keyboardWillShowNotification, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDisappears), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func removeNotificationObservers() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        container.addGestureRecognizer(gesture)

    }

    private func setupImageView() {
        let image = UIImageView()
        imageView = image
        image.isUserInteractionEnabled = true
        image.image = UIImage(systemName: "camera.circle.fill")
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

    deinit {
        print("\(self) \(#function)")
    }
}

extension CreateLibraryUserViewController: SingleImageManagerDelelgate {

    func didDeleteImageFromDocument(error: Error?) {
        // 
    }
    

    func didSaveImageToDocument(filename: String?, error: Error?) {
        guard let filename, error == nil else {
            print("Error \(error?.localizedDescription)")
            return
        }
        userSelectedImageName = filename
        let user = Library.Create.User(name: nameView.text, phone: phoneView.text, age: ageView.text, address: addressView.text, profileImage: filename, planStart: startingView.text ?? "", planEnd: expiryView.text ?? "", amount: amountView.text)
        interactor?.createUser(using: .init(user: user))
    }
}


extension CreateLibraryUserViewController: CreateLibraryUserDisplayLogic {

    func displayCreateLibraryUser(response: Library.Create.ViewModel) {
        
        guard let userSelectedImageName else { return }
        switch response.state {

        case .success:
            handleSuccessResponse()
        case .error(let error):
            manager.deleteImage(image: userSelectedImageName)
            print("Error \(error.localizedDescription)")
        }
    }

    private func handleSuccessResponse() {
        sendUserCreatedNotification()
        navigationController?.popViewController(animated: true)
    }

    private func sendUserCreatedNotification() {
        NotificationCenter.default.post(name: Notification.Name(LibraryConstants.userCreated), object: nil)
    }
}

// MARK :- Photo picker
extension CreateLibraryUserViewController: PHPickerViewControllerDelegate, UINavigationControllerDelegate {

    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        defer {
            dismiss(animated: true)
        }
        handleCameraClicked(results: results)
    }

    private func handleCameraClicked(results: [PHPickerResult]) {
        guard let provider = results.first?.itemProvider else { return }
        if(provider.canLoadObject(ofClass: UIImage.self)) {
            provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self, let image = image as? UIImage, error == nil else { return }
                    self.userSelectedImage = image
                    self.imageView.image = image
                }
            }
        }
    }
}

extension CreateLibraryUserViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        guard let textView = textView as? PlaceholderTextView else { return }
        if(textView.text.isEmpty) {
            textView.showPlaceholder()
        } else if (textView.text.count == 1) {
            textView.hidePlaceholder()
        }
    }
}

// MARK :- UI for detail Container
extension CreateLibraryUserViewController {

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
        container.layer.borderColor = UIColor.lightGray.cgColor
        container.layer.borderWidth = 1
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 6, left: 12, bottom: 0, right: 12)
        container.clipsToBounds = true
        container.layer.cornerRadius = 12
        container.axis = .vertical
        container.spacing = 0
        let label = getLabel(text: "Name")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "Pranjal Agarwal")
        nameView = tf
        tf.keyboardType = .asciiCapable
        container.addArrangedSubview(tf)
        let separator = getSeparator()
//        container.addArrangedSubview(separator)
        detailContainerView.addArrangedSubview(container)
    }

    private func setupPhoneView() {
        let container = UIStackView()
        container.spacing = 20
        detailContainerView.addArrangedSubview(container)

        let sContainer = UIStackView()
        sContainer.axis = .vertical
        let label1 = getLabel(text: "Phone")
        label1.numberOfLines = 0
        let tv1 = getTextView(text: "8209131942")
        phoneView = tv1
        tv1.keyboardType = .asciiCapableNumberPad
        let sep1 = getSeparator()
        sContainer.addArrangedSubview(label1)
        sContainer.addArrangedSubview(tv1)

        sContainer.layer.borderColor = UIColor.lightGray.cgColor
        sContainer.layer.borderWidth = 1
        sContainer.isLayoutMarginsRelativeArrangement = true
        sContainer.layoutMargins = .init(top: 6, left: 12, bottom: 0, right: 12)
        sContainer.clipsToBounds = true
        sContainer.layer.cornerRadius = 12
//        sContainer.addArrangedSubview(sep1)

        let eContainer = UIStackView()
        eContainer.axis = .vertical
        let label2 = getLabel(text: "Age")
        let tv2 = getTextView(text: "24")
        ageView = tv2
        tv2.keyboardType = .asciiCapableNumberPad
        let sep2 = getSeparator()
        eContainer.addArrangedSubview(label2)
        eContainer.addArrangedSubview(tv2)
//        eContainer.addArrangedSubview(sep2)

        eContainer.layer.borderColor = UIColor.lightGray.cgColor
        eContainer.layer.borderWidth = 1
        eContainer.isLayoutMarginsRelativeArrangement = true
        eContainer.layoutMargins = .init(top: 6, left: 12, bottom: 0, right: 12)
        eContainer.clipsToBounds = true
        eContainer.layer.cornerRadius = 12
        container.addArrangedSubview(sContainer)
        container.addArrangedSubview(eContainer)
    }

    private func setupAddressView() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        container.layer.borderColor = UIColor.lightGray.cgColor
        container.layer.borderWidth = 1
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 12, left: 12, bottom: 0, right: 12)
        container.clipsToBounds = true
        container.layer.cornerRadius = 12
        let label = getLabel(text: "Current Address")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "Manas hospital")
        addressView = tf
        tf.keyboardType = .asciiCapable
        container.addArrangedSubview(tf)
        let separator = getSeparator()
//        container.addArrangedSubview(separator)
        detailContainerView.addArrangedSubview(container)
    }

    private func setupRentStartEndContainer() {
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(selectDate))
        let gestur2 = UITapGestureRecognizer(target: self, action: #selector(selectDate))
        let container = UIStackView()
        container.spacing = 20
        container.distribution = .fillEqually
        detailContainerView.addArrangedSubview(container)
        let sContainer = UIStackView()
        sContainer.spacing = 6
        sContainer.axis = .vertical
        let label1 = getLabel(text: "Rent Start date")
        let tv1 = getLabel(text: "20-07-2024")
        tv1.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        tv1.textColor = .gray
        tv1.isUserInteractionEnabled = true
        tv1.addGestureRecognizer(gesture1)
        startingView = tv1
        let sep1 = getSeparator()
        sContainer.addArrangedSubview(label1)
        sContainer.addArrangedSubview(tv1)

        sContainer.layer.borderColor = UIColor.lightGray.cgColor
        sContainer.layer.borderWidth = 1
        sContainer.isLayoutMarginsRelativeArrangement = true
        sContainer.layoutMargins = .init(top: 6, left: 12, bottom: 10, right: 12)
        sContainer.clipsToBounds = true
        sContainer.layer.cornerRadius = 12
//        sContainer.addArrangedSubview(sep1)

        let eContainer = UIStackView()
        eContainer.axis = .vertical
        eContainer.spacing = 6
        let label2 = getLabel(text: "Rent end date")
        let tv2 = getLabel(text: "20-07-2024")
        tv2.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        tv2.isUserInteractionEnabled = true
        tv2.addGestureRecognizer(gestur2)
        tv2.textColor = .gray
        expiryView = tv2
        let sep2 = getSeparator()
        eContainer.addArrangedSubview(label2)
        eContainer.addArrangedSubview(tv2)
        eContainer.layer.borderColor = UIColor.lightGray.cgColor
        eContainer.layer.borderWidth = 1
        eContainer.isLayoutMarginsRelativeArrangement = true
        eContainer.layoutMargins = .init(top: 6, left: 12, bottom: 10, right: 12)
        eContainer.clipsToBounds = true
        eContainer.layer.cornerRadius = 12
//        eContainer.addArrangedSubview(sep2)

        container.addArrangedSubview(sContainer)
        container.addArrangedSubview(eContainer)
    }

    private func setupRentView() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        container.layer.borderColor = UIColor.lightGray.cgColor
        container.layer.borderWidth = 1
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 6, left: 12, bottom: 0, right: 12)
        container.clipsToBounds = true
        container.layer.cornerRadius = 12
        let label = getLabel(text: "Amount in ₹")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "2000")
        amountView = tf
        tf.keyboardType = .asciiCapableNumberPad
        container.addArrangedSubview(tf)
        let separator = getSeparator()
//        container.addArrangedSubview(separator)
        detailContainerView.addArrangedSubview(container)
    }
}

// UI :- Label PlaceHolder, Separator
extension CreateLibraryUserViewController {

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
        tv.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        tv.setTranslatesMask()
        let height = tv.heightAnchor.constraint(greaterThanOrEqualToConstant: 23)
        NSLayoutConstraint.activate([height])
        return tv
    }
}

// MARK :- UI, Property related and CreateButton
extension CreateLibraryUserViewController {

    private func setupCreateButton() {
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
        let top = button.topAnchor.constraint(equalTo: detailContainerView.bottomAnchor, constant: 30)
        let bottom = button.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        let width = button.widthAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([centerX, bottom, width, top])
    }
}

