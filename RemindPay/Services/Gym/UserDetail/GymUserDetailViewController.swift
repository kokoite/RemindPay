//
//  UserDetailViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 18/07/24.
//

import UIKit
import SwiftUI

protocol GymUserDetailDisplayLogic: AnyObject {

    func displayFetchUserDetail(using response: Gym.Fetch.ViewModel)
}

final class GymUserDetailViewController: UIViewController {

    private var containerScrollView: UIScrollView!
    private var carouselView: CarouselView!
    private var containerView, separatorView, carouselContainer: UIView!
    private var nameView, phoneView, gymJoined, planStarted, planExpiry,
                addressView, diseaseView, weightView, heightView,
                activeView, lastPaymentAmountView, lastPaymentDateView
    : PlaceholderTextView!



    private var chartContainer: UIStackView!
    private var editButton: UIButton!

    private var detailContainerView, userDetailContainerView: UIStackView!
    private var interactor: GymUserDetailBusinessLogic?
    var router: (GymUserDetailRoutingLogic & GymUserDetailDataPassing)?
    private var presenter: GymUserDetailPresenter?


    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func initialize() {
        let interactor = GymUserDetailInteractor()
        let router = GymUserDetailRouter()
        let presenter = GymUserDetailPresenter()
        interactor.presenter = presenter
        presenter.viewController = self
        router.dataStore = interactor
        self.router = router
        self.interactor = interactor
        self.presenter = presenter
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

    @objc func editButtonClicked() {
        print("Edit button clicked \(self)")
    }

    private func setup() {
        setupScrollContainer()
        setupContainer()
        setupDetailContainer()
        setupCarouselContainer()
        setupCarousel()
        setupUserDetailContainer()
        setupUserDetails()

//        setupUserChartContainer()
//        setupWeightChart()
//        setupHeightChart()

        setupEditButton()
        interactor?.fetchUserDetails()
    }

    private func setupScrollContainer() {
        let container = UIScrollView()
        container.backgroundColor = .cardBackground
        containerScrollView = container
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)
        container.showsVerticalScrollIndicator = false
    }


    private func setupContainer() {
        let container = UIView()
        containerView = container
        containerScrollView.addSubview(container)
        container.backgroundColor  = .cardBackground
        container.setTranslatesMask()
        container.pinToEdges(in: containerScrollView)
        container.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
    }

    private func setupDetailContainer() {
        let container = UIStackView()
        detailContainerView = container
        container.setTranslatesMask()
        containerView.addSubview(container)
        container.axis = .vertical
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 20, left: 20, bottom: 20, right: 20)
        container.pinToEdges(in: containerView)
        container.layer.cornerRadius = 20
        container.clipsToBounds = true
        container.spacing = 25
    }

    private func setupCarouselContainer() {
        let container = UIView()
        carouselContainer = container
        container.backgroundColor = .white
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
        detailContainerView.addArrangedSubview(container)
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

    private func setupUserChartContainer() {
        let container = UIStackView()
        container.backgroundColor = .white
        container.axis = .vertical
        container.spacing = 40
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 0, left: 12, bottom: 20, right: 12)
        chartContainer = container
        detailContainerView.addArrangedSubview(container)
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
    }

    private func setupWeightChart() {
        let chart = LineChart()
        let controller = UIHostingController(rootView: chart)
        addChild(controller)
        controller.didMove(toParent: self)
        chartContainer.addArrangedSubview(controller.view)
    }

    private func setupHeightChart() {
        let chart = LineChart()
        let controller = UIHostingController(rootView: chart)
        addChild(controller)
        controller.didMove(toParent: self)
        chartContainer.addArrangedSubview(controller.view)
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
}

extension GymUserDetailViewController: GymUserDetailDisplayLogic {

    func displayFetchUserDetail(using response: Gym.Fetch.ViewModel) {
        switch response.state {
        case .success(let vm):
            configure(using: vm)
        case .error(let error):
            print("Error is \(error.localizedDescription)")
        }
    }

    private func configure(using vm: Gym.Fetch.User) {
        nameView.text = vm.name
        phoneView.text = vm.phone
        addressView.text = vm.address
        diseaseView.text = vm.disease
        planStarted.text = vm.planStarting
        planExpiry.text = vm.planEnding
        lastPaymentAmountView.text = vm.lastPaymentAmount
        carouselView.configure(images: vm.profileImage)
    }
}

extension GymUserDetailViewController: CarouselViewDelegate {
    func didSelectItemAtIndexPath(indexPath: IndexPath) {
        print("item selected at index path \(indexPath)")
    }
    
    func didScrollToItemAtIndexPath(indexPath: IndexPath) {
    }
    
    func numberOfItemsInCarousel() -> Int {
        return 10
    }
}


// User Detail Container
extension GymUserDetailViewController {

    private func setupUserDetailContainer() {
        let container = UIStackView()
        container.spacing = 10
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
        container.axis = .vertical
        container.backgroundColor = .white
        container.clipsToBounds = true
        container.layer.cornerRadius = 20
        userDetailContainerView = container
        detailContainerView.addArrangedSubview(container)
    }

    private func setupUserDetails() {
        setupNameContainer()
        setupPhoneContainer()
        setupWeightAndHeightContainer()
        setupDisease()
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

        container.backgroundColor = .white
        userDetailContainerView.addArrangedSubview(container)
        let label = getLabel(text: "Phone")
        let view = getLabelContentView(text: "+91 8209131942")

        container.addArrangedSubview(label)
        phoneView = view
        container.addArrangedSubview(view)
    }

    private func setupWeightAndHeightContainer() {
        let container = UIStackView()

        container.spacing = 20
        userDetailContainerView.addArrangedSubview(container)
        let weight = UIStackView()
        weight.spacing = 0
        weight.axis = .vertical
        container.addArrangedSubview(weight)
        let weightLabel = getLabel(text: "Weight")
        let weightText = getLabelContentView(text: "80 kg")
        weightView = weightText

        weight.addArrangedSubview(weightLabel)
        weight.addArrangedSubview(weightText)

        let height = UIStackView()
        height.spacing = 0
        height.axis = .vertical
        container.addArrangedSubview(height)
        let heightLabel = getLabel(text: "Height")
        let heightText = getLabelContentView(text: "180 cms")
        heightView = heightText

        height.addArrangedSubview(heightLabel)
        height.addArrangedSubview(heightText)
    }

    private func setupDisease() {
        let container = UIStackView()
        container.axis = .vertical

        userDetailContainerView.addArrangedSubview(container)
        let label = getLabel(text: "Existing disease")
        let text = getLabelContentView(text: "Nothing")
        diseaseView = text
        container.addArrangedSubview(label)
        container.addArrangedSubview(text)
    }

    private func setupAddress() {
        let container = UIStackView()
        container.axis = .vertical

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
        let joinedLabel = getLabel(text: "Joined on")
        let joinedText = getLabelContentView(text: "20-07-2024")
        gymJoined = joinedText

        joined.addArrangedSubview(joinedLabel)
        joined.addArrangedSubview(joinedText)

        let active = UIStackView()
        active.spacing = 0
        active.axis = .vertical
        container.addArrangedSubview(active)
        let activeLabel = getLabel(text: "Current Status")
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
        let joinedLabel = getLabel(text: "Plan started date")
        let joinedText = getLabelContentView(text: "20-07-2024")
        planStarted = joinedText
        joined.addArrangedSubview(joinedLabel)
        joined.addArrangedSubview(joinedText)
        let active = UIStackView()
        active.spacing = 0
        active.axis = .vertical
        container.addArrangedSubview(active)
        let activeLabel = getLabel(text: "Plan expiry Date")
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
        let joinedLabel = getLabel(text: "Payment Date")
        let joinedText = getLabelContentView(text: "20-07-2024")
        lastPaymentDateView = joinedText

        joined.addArrangedSubview(joinedLabel)
        joined.addArrangedSubview(joinedText)

        let active = UIStackView()
        active.spacing = 0
        active.axis = .vertical
        container.addArrangedSubview(active)
        let activeLabel = getLabel(text: "Payment Amount")
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
