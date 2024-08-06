//
//  TenantDetailViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 28/07/24.
//

import UIKit


protocol TenantDisplayLogic: AnyObject {

    func displayFetchUser(using vm: Rent.Fetch.ViewModel)
}

final class TenantDetailViewController: UIViewController {

    private var containerScrollView: UIScrollView!
    private var carouselView: CarouselView!
    private var  userDetailContainerView: UIStackView!
    private var containerView, separatorView, carouselContainer: UIView!
    private var nameView, phoneView, joinedView, planStarted, planExpiry, addressView, lastPaymentDateView, lastPaymentAmountView, advanceView, securityView, activeView, paymentView
    : PlaceholderTextView!

    var router: (TenantRoutingLogic & TenantDataPassing)?
    var interactor: (TenantBusinessLogic & TenantDataStore)?
    var presenter: (TenantPresentingLogic)?
    private var editButton: UIButton!


    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cardBackground
        setup()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.tintColor = .black
    }

    func configure() {

    }

    @objc func editButtonClicked() {

    }

    private func initialize() {
        let router = TenantRouter()
        let interactor = TenantInteractor()
        let presenter = TenantPresenter()
        interactor.presenter = presenter
        presenter.viewController = self
        router.dataStore = interactor
        self.interactor = interactor
        self.router = router
        self.presenter = presenter
    }

    private func setup() {
        setupScrollContainer()
        setupContainer()
        setupCarouselContainer()
        setupCarousel()
        setupUserDetailContainer()
        setupUserDetails()
        setupEditButton()
        interactor?.fetchUser(using: .init())
    }
}

extension TenantDetailViewController: CarouselViewDelegate {
    func didSelectItemAtIndexPath(indexPath: IndexPath) {
        print("item selected at index path \(indexPath)")
    }

    func didScrollToItemAtIndexPath(indexPath: IndexPath) {
    }

    func numberOfItemsInCarousel() -> Int {
        return 10
    }
}

// Tenant Detail Container
extension TenantDetailViewController: TenantDisplayLogic {

    func displayFetchUser(using vm: Rent.Fetch.ViewModel) {
        switch vm.state {

        case .success(let user):
            handleSuccess(using: user)

        case .error(let error):
            handleError(using: error)
        }
    }

    private func handleSuccess(using user: Rent.Fetch.ViewModel.User) {
        carouselView.configure(images: user.propertyImages)
        nameView.text = user.name
        phoneView.text = user.phone
        addressView.text = user.address

    }

    private func handleError(using error: Error) {

    }
}


// MARK :- UI related setup
extension TenantDetailViewController {

    private func setupScrollContainer() {
        let container = UIScrollView()
        container.backgroundColor = .cardBackground
        container.layer.cornerRadius = 20
        container.clipsToBounds = true
        containerScrollView = container
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)
        container.showsVerticalScrollIndicator = false
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        container.layer.cornerRadius = 20
        container.clipsToBounds = true
        containerScrollView.addSubview(container)
        container.backgroundColor  = .cardBackground
        container.setTranslatesMask()
        container.pinToEdges(in: containerScrollView)
        container.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
    }

    private func setupCarouselContainer() {
        let container = UIView()
        carouselContainer = container
        container.backgroundColor = .white
        container.layer.cornerRadius = 20
        container.clipsToBounds = true
        container.setTranslatesMask()
        containerView.addSubview(container)
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20)
        NSLayoutConstraint.activate([leading, top, trailing])
    }

    private func setupCarousel() {
        let container = CarouselView()
        carouselView = container
        container.delegate = self
        carouselContainer.addSubview(container)
        container.setTranslatesMask()
        let centerX = container.centerXAnchor.constraint(equalTo: carouselContainer.centerXAnchor)
        let top = container.topAnchor.constraint(equalTo: carouselContainer.topAnchor, constant: 12)
        let width = container.widthAnchor.constraint(equalToConstant: view.bounds.width*0.8 - 40)
        let height = container.heightAnchor.constraint(equalToConstant: 300)
        let bottom = container.bottomAnchor.constraint(equalTo: carouselContainer.bottomAnchor, constant: -12)
        NSLayoutConstraint.activate([centerX, top, height, width, bottom])
    }

    private func setupEditButton() {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.image = UIImage(systemName: "pencil")
        let button = UIButton(configuration: config)
        button.clipsToBounds = true
        button.contentMode = .scaleAspectFit
        editButton = button
        button.layer.cornerRadius = 30
        button.tintColor = .black
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(editButtonClicked), for: .touchUpInside)
        containerScrollView.addSubview(button)
        button.setTranslatesMask()
        let height = button.heightAnchor.constraint(equalToConstant: 60)
        let width = button.widthAnchor.constraint(equalToConstant: 60)
        let trailng = button.trailingAnchor.constraint(equalTo: containerScrollView.trailingAnchor, constant: -20)
        let bottom = button.bottomAnchor.constraint(equalTo: containerScrollView.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        NSLayoutConstraint.activate([height, width, trailng, bottom])
    }

    private func setupUserDetailContainer() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 12
        container.backgroundColor = .white
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 20, left: 12, bottom: 20, right: 12)
        userDetailContainerView = container
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: carouselContainer.bottomAnchor, constant: 20)
        let bottom = container.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }

    private func setupUserDetails() {
        setupNameContainer()
        setupPhoneContainer()
        setupAdvanceAndSecurityContainer()
        setupAddress()
        setupJoinedAndActive()
        setupPlanStartAndExpiry()
        setupPaymentDateAndAmount()
    }

    private func setupNameContainer() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0


        container.backgroundColor = .white
        userDetailContainerView.addArrangedSubview(container)
        let label = getLabel(text: "Name")
        let view = getLabelContentView(text: "Pranjal")
        nameView = view

        container.addArrangedSubview(label)
        container.addArrangedSubview(view)
    }

    private func setupPhoneContainer() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0


        userDetailContainerView.addArrangedSubview(container)

        let label = getLabel(text: "Phone")
        let view = getLabelContentView(text: "+91 8209131942")
        phoneView = view

        container.addArrangedSubview(label)
        container.addArrangedSubview(view)
    }

    private func setupAdvanceAndSecurityContainer() {
        let container = UIStackView()

        container.spacing = 20

        let weight = UIStackView()
        weight.spacing = 0
        weight.axis = .vertical
        container.addArrangedSubview(weight)
        let weightLabel = getLabel(text: "Advance amount paid ")
        let weightText = getLabelContentView(text: "₹20000")
        advanceView = weightText

        weight.addArrangedSubview(weightLabel)
        weight.addArrangedSubview(weightText)

        let height = UIStackView()
        height.spacing = 0
        height.axis = .vertical
        container.addArrangedSubview(height)
        let heightLabel = getLabel(text: "Security amount paid")
        let heightText = getLabelContentView(text: "₹18000")
        securityView = heightText

        height.addArrangedSubview(heightLabel)
        height.addArrangedSubview(heightText)
        userDetailContainerView.addArrangedSubview(container)
    }

    private func setupAddress() {
        let container = UIStackView()
        container.axis = .vertical
        container.spacing = 0

        userDetailContainerView.addArrangedSubview(container)
        let label = getLabel(text: "Current Address")
        let text = getLabelContentView(text: "Manas Hospital")
        addressView = text

        container.addArrangedSubview(label)
        container.addArrangedSubview(text)
    }


    private func setupJoinedAndActive() {
        let container = UIStackView()

        container.spacing = 20

        userDetailContainerView.addArrangedSubview(container)
        let joined = UIStackView()
        joined.spacing = 0
        joined.axis = .vertical
        container.addArrangedSubview(joined)
        let joinedLabel = getLabel(text: "Started living from")
        let joinedText = getLabelContentView(text: "20-07-2024")
        joinedView = joinedText

        joined.addArrangedSubview(joinedLabel)
        joined.addArrangedSubview(joinedText)

        let active = UIStackView()
        active.spacing = 0
        active.axis = .vertical
        container.addArrangedSubview(active)
        let activeLabel = getLabel(text: "Current status")
        let activeText = getLabelContentView(text: "Active")
        activeView = activeText

        active.addArrangedSubview(activeLabel)
        active.addArrangedSubview(activeText)
    }

    private func setupPlanStartAndExpiry() {
        let container = UIStackView()
        container.spacing = 20

        userDetailContainerView.addArrangedSubview(container)
        let joined = UIStackView()
        joined.spacing = 0
        joined.axis = .vertical
        container.addArrangedSubview(joined)
        let joinedLabel = getLabel(text: "Rent started date")
        let joinedText = getLabelContentView(text: "20-07-2024")
        planStarted = joinedText
        joined.addArrangedSubview(joinedLabel)
        joined.addArrangedSubview(joinedText)
        let active = UIStackView()
        active.spacing = 0
        active.axis = .vertical
        container.addArrangedSubview(active)
        let activeLabel = getLabel(text: "Rent expiry Date")
        let activeText = getLabelContentView(text: "20-12-2024")
        planExpiry = activeText

        active.addArrangedSubview(activeLabel)
        active.addArrangedSubview(activeText)
    }

    private func setupPaymentDateAndAmount() {
        let container = UIStackView()

        container.spacing = 20

        userDetailContainerView.addArrangedSubview(container)
        let joined = UIStackView()
        joined.spacing = 0
        joined.axis = .vertical
        container.addArrangedSubview(joined)
        let joinedLabel = getLabel(text: "Last Payment Date")
        let joinedText = getLabelContentView(text: "20-07-2024")

        lastPaymentDateView = joinedText


        joined.addArrangedSubview(joinedLabel)
        joined.addArrangedSubview(joinedText)

        let active = UIStackView()
        active.spacing = 0
        active.axis = .vertical
        container.addArrangedSubview(active)
        let activeLabel = getLabel(text: "Last Payment Amount")
        let activeText = getLabelContentView(text: "₹2000")
        lastPaymentAmountView = activeText

        active.addArrangedSubview(activeLabel)
        active.addArrangedSubview(activeText)
    }

    private func getLabel(text: String) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }

    private func getLabelContentView(text: String) -> PlaceholderTextView {
        let tv = PlaceholderTextView()
        tv.text = text
        tv.textContainer.lineFragmentPadding = 0
        tv.isEditable = false
        tv.isScrollEnabled = false
        tv.textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 4, right: 8)
        tv.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        tv.setTranslatesMask()

        let height = tv.heightAnchor.constraint(greaterThanOrEqualToConstant: 25)
        NSLayoutConstraint.activate([height])
        return tv
    }

    private func getSeparator() -> UIView {
        let view = UIView()
        view.backgroundColor = .gray
        view.setTranslatesMask()
        let height = view.heightAnchor.constraint(equalToConstant: 1)
        NSLayoutConstraint.activate([height])
        return view
    }
}
