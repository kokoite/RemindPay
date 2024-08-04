//
//  CreateGymUserViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 19/07/24.
//

import UIKit
import PhotosUI

protocol CreateGymUserDisplayLogic: AnyObject {
    func displayCreateUser(response: Gym.Create.Response)
}

final class CreateGymUserViewController: UIViewController, UINavigationControllerDelegate {

    private var containerScrollView: UIScrollView!
    private var containerView: UIView!
    private var imageView: UIImageView!
    private var createButton: UIButton!
    private var detailContainerView: UIStackView!
    private var nameView, phoneView, weightView,
                heightView,
                paymentView,
                addressView, diseaseView, ageView
    : PlaceholderTextView!
    private var joinedView, expiryView: UILabel!
    private var interactor: CreateGymUserBusinessLogic?
    private var imageManager: ImageManager!
    private var dateController: DatePickerController!
    private var selectedImageFilename: String!
    private var selectedImage: UIImage?


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
        imageManager.singleImageDelegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        imageManager.singleImageDelegate = nil
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
        }
        present(controller, animated: true)
    }

    @objc func createButtonClicked() {
        guard let selectedImage else {
            // show Bottom sheet
            return
        }
        imageManager.saveImageToDocuments(image: selectedImage)
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

    @objc func dismissKeyboard() {
        view.endEditing(false)
    }

    private func initialize() {
        dateController = DatePickerController()
        let interactor = CreateGymUserInteractor()
        interactor.viewController = self
        self.interactor = interactor
        imageManager = ImageManager.instance
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


extension CreateGymUserViewController: CreateGymUserDisplayLogic {
    func displayCreateUser(response: Gym.Create.Response) {
        switch response.state {
        case .success:
            NotificationCenter.default.post(name: Notification.Name(GymConstant.userAdded), object: nil)
            navigationController?.popViewController(animated: true)
        case .error(let error):
            // show bottom sheet
            print("Error \(error.localizedDescription)")
            imageManager.deleteImage(image: selectedImageFilename)
        }
    }
}

extension CreateGymUserViewController: SingleImageManagerDelelgate {

    func didSaveImageToDocument(filename: String?, error: Error?) {
        guard let filename, error == nil else {
            // show bottom sheet
            return
        }
        selectedImageFilename = filename
        let user = Gym.User(id: UUID(),name: nameView.text, phone: phoneView.text, address: addressView.text, disease: diseaseView.text, planStarting: "20-08-2024", planEnding: "20-12-2024", joinedDate: "20-08-2024", lastPaymentDate: "20-08-2024",lastPaymentAmount: "2000", age: ageView.text, planAmount: paymentView.text, weight: [weightView.text], height: [heightView.text], profileImage: [selectedImageFilename])
        interactor?.createUser(request: .init(user: user))
    }

    func didDeleteImageFromDocument(error: Error?) {
        guard error == nil else {
            // show bottom sheet
            return
        }
        
        // stop the loader
    }
}


extension CreateGymUserViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        defer {
            dismiss(animated: true)
        }
        guard let provider = results.first?.itemProvider else { return }
        if(provider.canLoadObject(ofClass: UIImage.self)) {
            provider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                DispatchQueue.main.async {
                    guard let self, let image = image as? UIImage, error == nil else { return }
                    self.selectedImage = image
                    self.imageView.image = image
                }
            }
        }
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
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        container.addGestureRecognizer(gesture)
    }


    fileprivate func setupImageView() {
        let image = UIImageView()
        imageView = image
        image.isUserInteractionEnabled = true
        image.image = UIImage(systemName: "camera.circle.fill")
        image.contentMode = .scaleAspectFill
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
        image.layer.cornerRadius = 20
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
        container.spacing = 20
        detailContainerView.addArrangedSubview(container)

        let sContainer = UIStackView()
        sContainer.axis = .vertical
        let label1 = getLabel(text: "Phone number")
        label1.numberOfLines = 0
        let tv1 = getTextView(text: "8010923834")
        phoneView = tv1
        let sep1 = getSeparator()
        sContainer.addArrangedSubview(label1)
        sContainer.addArrangedSubview(tv1)
        sContainer.addArrangedSubview(sep1)

        let eContainer = UIStackView()
        eContainer.axis = .vertical
        let label2 = getLabel(text: "Age")
        let tv2 = getTextView(text: "24")
        ageView = tv2
        let sep2 = getSeparator()
        eContainer.addArrangedSubview(label2)
        eContainer.addArrangedSubview(tv2)
        eContainer.addArrangedSubview(sep2)

        container.addArrangedSubview(sContainer)
        container.addArrangedSubview(eContainer)
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

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectDate))
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectDate))
        let sContainer = UIStackView()
        sContainer.axis = .vertical
        sContainer.spacing = 8
        let label1 = getLabel(text: "Plan Starting date")
        label1.numberOfLines = 0
        let date = getTodaysDate()
        let tv1 = getLabel(text: date)
        tv1.isUserInteractionEnabled = true
        tv1.addGestureRecognizer(gesture)
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
