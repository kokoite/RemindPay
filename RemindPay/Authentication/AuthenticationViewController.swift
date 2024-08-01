//
//  LoginViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 31/07/24.
//

import UIKit
import AVFoundation
import PhotosUI


protocol AuthenticationDisplayLogic: AnyObject {
    
    func displayCreateUser(response: Authentication.Create.Response)
    func displayFetchUser()
}

final class AuthenticationViewController: UIViewController {

    private var containerScrollView: UIScrollView!
    private var containerView: UIView!
    private var imageView: UIImageView!
    private var createButton: UIButton!
    private var selectedImage: UIImage?
    private var selectedImageUrl: String?

    private var nameView, phoneView, addressView, emailView: PlaceholderTextView!
    private var detailContainerView: UIStackView!

    private var interactor: AuthenticationBusinessLogic?

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true

    }

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
        let url = saveImageToDocuments()
        let user = User(id: UUID(), name: nameView.text, phone: phoneView.text, email: emailView.text, profileImageUrl: url , membership: .free)
        print("user \(user)")
        interactor?.createUser(user: user)
    }

    private func saveImageToDocuments() -> String {
        guard let selectedImage else { return ""}
        guard let jpeg = selectedImage.jpegData(compressionQuality: 0.7) else { return ""}
        let documentUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = UUID().uuidString + ".jpg"
        let fileUrl = documentUrl.appending(path: fileName)
        do {
            try jpeg.write(to: fileUrl, options: .atomic)
        } catch {
            print("unable to write in specific folder")
        }
        return fileUrl.path()
    }

    private func initialize() {
        let viewController = self
        let interactor = AuthenticationInteractor()
        interactor.viewController = viewController
        self.interactor = interactor
    }

    private func setup() {
        view.backgroundColor = .white
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
        container.backgroundColor = .white
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToSafeEdges(in: view)
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
        container.backgroundColor = .white
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

    private func setupEmailContainer() {
        let container = UIStackView()
        container.spacing = 0
        detailContainerView.addArrangedSubview(container)
        container.axis = .vertical
        let label = getLabel(text: "Email")
        let tv = getTextView(text: "doejohn@gmail.com")
        emailView = tv
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
        phoneView = tf
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
        tv1.isUserInteractionEnabled = false
        let sep1 = getSeparator()
        sContainer.addArrangedSubview(label1)
        sContainer.addArrangedSubview(tv1)
        sContainer.addArrangedSubview(sep1)

        let eContainer = UIStackView()
        eContainer.axis = .vertical
        let label2 = getLabel(text: "Memberhship charges")
        let tv2 = getTextView(text: "₹0")
        tv2.isUserInteractionEnabled = false
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
        button.setTitle("Join the app", for: .normal)
        button.addTarget(self, action: #selector(createUserClicked), for: .touchUpInside)
        containerView.addSubview(button)
        button.setTranslatesMask()
        let centerX = button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let top = button.topAnchor.constraint(equalTo: detailContainerView.bottomAnchor, constant: 30)
        let width = button.widthAnchor.constraint(equalToConstant: 150)
        NSLayoutConstraint.activate([centerX, top, width])
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

extension AuthenticationViewController: PHPickerViewControllerDelegate {
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


extension AuthenticationViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        guard let textView = textView as? PlaceholderTextView else { return }
        if(textView.text.isEmpty) {
            textView.showPlaceholder()
        } else if (textView.text.count == 1) {
            textView.hidePlaceholder()
        }
    }
}

extension AuthenticationViewController: AuthenticationDisplayLogic {
    
    func displayCreateUser(response: Authentication.Create.Response) {
        print(response)
    }
    
    func displayFetchUser() {
        
    }
    

}

