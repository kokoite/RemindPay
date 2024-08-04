//
//  CreateTenantViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 28/07/24.
//


import UIKit
import PhotosUI


protocol CreateTenantDisplayLogic: AnyObject {
    func displayCreateTenant(response: Rent.Create.Response)
}

final class CreateTenantViewController: UIViewController {

    private var containerScrollView: UIScrollView!
    private var containerView: UIView!
    private var imageView: UIImageView!
    private var documentContainer: UIStackView!
    private var documentContainerCollection: UICollectionView!
    private var createButton: UIButton!
    private var selectedImages: [UIImage] = []
    private var propertyImages: [String] = []
    private var userImage: String!
    private var userSelectedImage: UIImage!

    private var nameView, phoneView, advanceView, securityView, rentView, utilityView, joinedView, startingView, expiryView, addressView: PlaceholderTextView!
    private var detailContainerView: UIStackView!
    private var cameraController, propertyController: PHPickerViewController!
    private var interactor: CreateTenantBusinessLogic?
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

    @objc func addPropertyClicked() {
        present(propertyController, animated: true)
    }

    @objc func createButtonClicked() {
        // Save images to documents directory
        Task { [weak self] in

            guard let self else { return }
            do {
                let propertyImages = try await manager.saveImages(images: selectedImages)
                self.propertyImages = propertyImages
                self.userImage = try await manager.saveImage(image: userSelectedImage)
                let id = UUID()
                let name = nameView.text ?? ""
                let phone = phoneView.text ?? ""
                let address = addressView.text ?? ""
                let rentStart = "20-07-2024"
                let rentEnd = "20-12-2024"
                let rent = rentView.text ?? ""
                let utilty = utilityView.text ?? ""
                let advance = advanceView.text ?? ""
                let security = securityView.text ?? ""
                let tenant = Tenant(id: id, name: name, phone: phone, address: address, profileImage: userImage, agreementStartDate: rentStart, agreementEndDate: rentEnd, rentStartDate: rentStart, rentExpireDate: rentEnd, joinedDate: rentStart, advanceAmount: advance, securityAmount: security, rentAmount: rent, utilityAmount: utilty, propertyImages: propertyImages)
                interactor?.createTenant(using: tenant)

            } catch (let error) {
                print("Error \(error.localizedDescription)")
            }
        }
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

    private func initialize() {
        var cameraConfig = PHPickerConfiguration()
        cameraConfig.filter = .images
        cameraConfig.selectionLimit = 1
        cameraController = PHPickerViewController(configuration: cameraConfig)
        cameraController.modalPresentationStyle = .fullScreen
        cameraController.delegate = self

        var propertyConfig = PHPickerConfiguration()
        propertyConfig.filter = .images
        propertyConfig.selectionLimit = 0
        propertyController = PHPickerViewController(configuration: propertyConfig)
        propertyController.modalPresentationStyle = .fullScreen
        propertyController.delegate = self


        let interactor = CreateTenantInteractor()
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
        setupAgreementStartEndContainer()
        setupAdvanceAndSecurityAmount()
        setupRentAndUtilityAmount()
        setupPropertyDocumentContainer()
        setupAddPropertyDoucment()
        setupPropertyDocumentCollection()
        setupCreateButton()
    }

    @objc func dismissKeyBoard() {
        view.endEditing(true)
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}


extension CreateTenantViewController: CreateTenantDisplayLogic {

    func displayCreateTenant(response: Rent.Create.Response) {

        let state = response.state
        switch(state) {
        case .success:
            print("success")
        case .error(let error):
            print("Error \(error.localizedDescription)")
            manager.deleteImage(image: userImage)
            manager.deleteImages(images: propertyImages)
        }
    }
}

// MARK :- Photo picker
extension CreateTenantViewController: PHPickerViewControllerDelegate, UINavigationControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        defer {
            dismiss(animated: true)
        }
        picker == cameraController ? handleCameraClicked(results: results): handlePropertyImageClicked(results: results)
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

    private func handlePropertyImageClicked(results: [PHPickerResult]) {
        var currentImages: [UIImage] = []
        let group = DispatchGroup()
            for result in results {
                group.enter()
                let provider = result.itemProvider
                if(provider.canLoadObject(ofClass: UIImage.self)) {
                    provider.loadObject(ofClass: UIImage.self) { image, error in
                        guard error == nil, let image = image as? UIImage else { return }
                        currentImages.append(image)
                        group.leave()
                    }
                }
        }

        group.notify(queue: .main) { [weak self] in
            guard let self else { return }
            selectedImages = currentImages
            self.documentContainerCollection.isHidden = currentImages.count == 0
            self.documentContainerCollection.reloadData()
        }
    }
}

extension CreateTenantViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        selectedImages.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "propertyCell", for: indexPath) as? PropertyCollectionViewCell else { 
            return UICollectionViewCell()
        }
        cell.configure(using: selectedImages[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 100, height: 100)
    }
}


extension CreateTenantViewController: UITextViewDelegate {

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
extension CreateTenantViewController {

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
        nameView = tf
        tf.keyboardType = .asciiCapable
        container.addArrangedSubview(tf)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        detailContainerView.addArrangedSubview(container)
    }

    private func setupPhoneView() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0
        let label = getLabel(text: "Phone")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "820 91375546")
        phoneView = tf
        tf.keyboardType = .asciiCapableNumberPad
        container.addArrangedSubview(tf)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
        detailContainerView.addArrangedSubview(container)
    }

    private func setupAddressView() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 6
        let label = getLabel(text: "Current Address")
        container.addArrangedSubview(label)
        let tf = getTextView(text: "Manas hospital")
        addressView = tf
        tf.keyboardType = .asciiCapable
        container.addArrangedSubview(tf)
        let separator = getSeparator()
        container.addArrangedSubview(separator)
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
        let sep1 = getSeparator()
        sContainer.addArrangedSubview(label1)
        sContainer.addArrangedSubview(tv1)
        sContainer.addArrangedSubview(sep1)

        let eContainer = UIStackView()
        eContainer.axis = .vertical
        eContainer.spacing = 6
        let label2 = getLabel(text: "Rent end date")
        let tv2 = getLabel(text: "20-07-2024")
        tv2.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        tv2.isUserInteractionEnabled = true
        tv2.addGestureRecognizer(gestur2)
        tv2.textColor = .gray
        let sep2 = getSeparator()
        eContainer.addArrangedSubview(label2)
        eContainer.addArrangedSubview(tv2)
        eContainer.addArrangedSubview(sep2)

        container.addArrangedSubview(sContainer)
        container.addArrangedSubview(eContainer)
    }

    private func setupAgreementStartEndContainer() {
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(selectDate))
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(selectDate))
        let container = UIStackView()
        container.spacing = 20
        detailContainerView.addArrangedSubview(container)
        let sContainer = UIStackView()
        sContainer.spacing = 6
        sContainer.axis = .vertical
        let label1 = getLabel(text: "Agreement start date")
        label1.numberOfLines = 0
        let tv1 = getLabel(text: "20-07-2024")
        tv1.isUserInteractionEnabled = true
        tv1.addGestureRecognizer(gesture1)
        tv1.font = UIFont.systemFont(ofSize: 16)
        tv1.textColor = .gray
        let sep1 = getSeparator()
        sContainer.addArrangedSubview(label1)
        sContainer.addArrangedSubview(tv1)
        sContainer.addArrangedSubview(sep1)

        let eContainer = UIStackView()
        eContainer.axis = .vertical
        eContainer.spacing = 6
        let label2 = getLabel(text: "Agreement expiry date")
        let tv2 = getLabel(text: "20-07-2024")
        tv2.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        tv2.textColor = .gray
        tv2.isUserInteractionEnabled = true
        tv2.addGestureRecognizer(gesture2)
        let sep2 = getSeparator()
        eContainer.addArrangedSubview(label2)
        eContainer.addArrangedSubview(tv2)
        eContainer.addArrangedSubview(sep2)

        container.addArrangedSubview(sContainer)
        container.addArrangedSubview(eContainer)
    }

    private func setupAdvanceAndSecurityAmount() {
        let container = UIStackView()
        container.spacing = 20
        detailContainerView.addArrangedSubview(container)

        let sContainer = UIStackView()
        sContainer.axis = .vertical
        let label1 = getLabel(text: "Advance amount paid")
        label1.numberOfLines = 0
        let tv1 = getTextView(text: "₹20000")
        advanceView = tv1
        tv1.keyboardType = .asciiCapableNumberPad
        let sep1 = getSeparator()
        sContainer.addArrangedSubview(label1)
        sContainer.addArrangedSubview(tv1)
        sContainer.addArrangedSubview(sep1)

        let eContainer = UIStackView()
        eContainer.axis = .vertical
        let label2 = getLabel(text: "Security amount paid")
        let tv2 = getTextView(text: "₹2000")
        securityView = tv2
        tv2.keyboardType = .asciiCapableNumberPad
        let sep2 = getSeparator()
        eContainer.addArrangedSubview(label2)
        eContainer.addArrangedSubview(tv2)
        eContainer.addArrangedSubview(sep2)

        container.addArrangedSubview(sContainer)
        container.addArrangedSubview(eContainer)
    }

    private func setupRentAndUtilityAmount() {
        let container = UIStackView()
        container.spacing = 20
        detailContainerView.addArrangedSubview(container)

        let sContainer = UIStackView()
        sContainer.axis = .vertical
        let label1 = getLabel(text: "Rent amount")
        label1.numberOfLines = 0
        let tv1 = getTextView(text: "₹20000")
        rentView = tv1
        tv1.keyboardType = .asciiCapableNumberPad
        let sep1 = getSeparator()
        sContainer.addArrangedSubview(label1)
        sContainer.addArrangedSubview(tv1)
        sContainer.addArrangedSubview(sep1)

        let eContainer = UIStackView()
        eContainer.axis = .vertical
        let label2 = getLabel(text: "Utility amount")
        let tv2 = getTextView(text: "₹2000")
        utilityView = tv2
        tv2.keyboardType = .asciiCapableNumberPad
        let sep2 = getSeparator()
        eContainer.addArrangedSubview(label2)
        eContainer.addArrangedSubview(tv2)
        eContainer.addArrangedSubview(sep2)

        container.addArrangedSubview(sContainer)
        container.addArrangedSubview(eContainer)
    }
}

// UI :- Label PlaceHolder, Separator
extension CreateTenantViewController {

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
        let height = tv.heightAnchor.constraint(greaterThanOrEqualToConstant: 25)
        NSLayoutConstraint.activate([height])
        return tv
    }
}

// MARK :- UI, Property related and CreateButton
extension CreateTenantViewController {

    private func setupPropertyDocumentContainer() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 30
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
        container.backgroundColor = .white
        documentContainer = container
        containerView.addSubview(container)
        container.setTranslatesMask()
        [
            container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            container.topAnchor.constraint(equalTo: detailContainerView.bottomAnchor, constant: 20)
        ].forEach { const in
            const.isActive = true
        }
    }

    private func setupAddPropertyDoucment() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20)
        let button = UIButton(configuration: config)
        button.tintColor = .black
        button.setTitle("Want to add property images?", for: .normal)
        button.addTarget(self, action: #selector(addPropertyClicked), for: .touchUpInside)
        documentContainer.addArrangedSubview(button)
    }

    private func setupPropertyDocumentCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 50
        layout.minimumLineSpacing = 20
        let container = UICollectionView(frame: .zero, collectionViewLayout: layout)
        container.contentInset = .init(top: 0, left: 20, bottom: 20, right: 0)
        container.isHidden = true
        container.dataSource = self
        container.delegate = self
        documentContainerCollection = container
        container.showsHorizontalScrollIndicator = false
        documentContainer.addArrangedSubview(container)
        container.register(PropertyCollectionViewCell.self, forCellWithReuseIdentifier: "propertyCell")
        container.setTranslatesMask()
        container.heightAnchor.constraint(equalToConstant: 120).isActive = true
    }

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
        let top = button.topAnchor.constraint(equalTo: documentContainer.bottomAnchor, constant: 12)
        let bottom = button.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        let width = button.widthAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([centerX, bottom, width, top])
    }
}
