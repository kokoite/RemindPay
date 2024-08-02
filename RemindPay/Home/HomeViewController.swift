//
//  HomeViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 23/07/24.
//

import UIKit

struct ServiceViewModel {
    let services: [ServiceType]
}

protocol HomeDisplayLogic: AnyObject {
    func displayFetchUserHeader(using vm: SimpleHeaderViewModel)
    func displaySubscribedServices(using vm: ServiceViewModel)
}

final class HomeViewController: UIViewController {
    private weak var containerScrollView: UIScrollView!
    private weak var containerView: UIView!
    fileprivate weak var headerView: SimpleHeaderView!
    private weak var serviceContainer, subscribedContainer: UIStackView!
    private weak var serviceLabel, subscribedLabel: UILabel!
    private weak var serviceCollection, subscribedCollection: UICollectionView!
    private var interactor: HomeBusinessLogic?
    private var presenter: HomePresentingLogic?
    private var safeAreaBottomHeight: CGFloat = 0

    private var membershipData: [MembershipViewModel] = [
        .init(backgroundColor: .systemYellow, imageName: "house.fill"),
        .init(backgroundColor: .systemGreen, imageName: "graduationcap.fill"),
        .init(backgroundColor: .systemPink, imageName: "dumbbell.fill"),
        .init(backgroundColor: .systemBlue, imageName: "book.fill")
    ]

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialize() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        interactor.presenter = presenter
        presenter.viewController = viewController
        self.presenter = presenter
        self.interactor = interactor
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = .white
        setupScrollView()
        setupContainer()
        setupHeader()
        setupServiceContainer()
        setupServiceLabel()
        setupServiceCollection()

        setupSubscribedContainer()
        setupSubscribedLabel()
        setupSubscribedCollection()

        interactor?.fetchUserDetails()
    }

    private func setupScrollView() {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .cardBackground
        containerScrollView = scrollView
        view.addSubview(scrollView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.setTranslatesMask()
        let top = scrollView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottom = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        let leading = scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }

    private func setupContainer() {
        let container = UIView()
        container.backgroundColor = .cardBackground
        containerView = container
        containerScrollView.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: containerScrollView)
        container.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
    }

    private func setupHeader() {
        let header = SimpleHeaderView()
        headerView = header
        header.layer.cornerRadius = 20
        header.clipsToBounds = true
        containerView.addSubview(header)
        header.setTranslatesMask()
        let leading = header.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let top = header.topAnchor.constraint(equalTo: containerView.topAnchor)
        let trailng = header.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let height = header.heightAnchor.constraint(equalToConstant: 80)
        NSLayoutConstraint.activate([leading, top, trailng, height])
    }

    private func setupServiceContainer() {
        let container = UIStackView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 20
        container.axis = .vertical
        container.spacing = 12
        container.clipsToBounds = true
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        serviceContainer = container
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, trailing, top])
    }

    private func setupServiceLabel() {
        let label = UILabel()
        serviceLabel = label
        label.text = "Services we provide"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        serviceContainer.addArrangedSubview(label)
    }

    private func setupServiceCollection() {
        let layout = UICollectionViewFlowLayout()
        let container = UICollectionView(frame: .zero, collectionViewLayout: layout)
        container.delegate = self
        container.dataSource = self
        container.showsVerticalScrollIndicator = false
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        container.register(MembershipCollectionViewCell.self, forCellWithReuseIdentifier: "membershipCell")
        serviceCollection = container
        serviceContainer.addArrangedSubview(container)
        container.setTranslatesMask()
        let height = container.heightAnchor.constraint(equalToConstant: 250)
        NSLayoutConstraint.activate([height])
    }

    private func setupNoAvailableServices() {

    }

    private func setupSubscribedContainer() {
        let container = UIStackView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 20
        container.axis = .vertical
        container.spacing = 12
        container.clipsToBounds = true
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        subscribedContainer = container
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailing = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: serviceContainer.bottomAnchor, constant: 40)
        let bottom = container.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([leading, trailing, top, bottom])
    }

    private func setupSubscribedLabel() {
        let label = UILabel()
        subscribedLabel = label
        label.text = "Subscribed Services"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        subscribedContainer.addArrangedSubview(label)
    }

    private func setupSubscribedCollection() {
        let layout = UICollectionViewFlowLayout()
        let container = UICollectionView(frame: .zero, collectionViewLayout: layout)
        container.delegate = self
        container.dataSource = self
        container.showsVerticalScrollIndicator = false
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 20
        container.register(MembershipCollectionViewCell.self, forCellWithReuseIdentifier: "membershipCell")
        subscribedCollection = container
        subscribedContainer.addArrangedSubview(container)
        container.setTranslatesMask()
        let height = container.heightAnchor.constraint(equalToConstant: 250)
        NSLayoutConstraint.activate([height])
    }

    deinit {
        print("Deinit called")
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "membershipCell", for: indexPath) as? MembershipCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(using: membershipData[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: view.bounds.width*0.35, height: view.bounds.width*0.3)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView == subscribedCollection ? handleSubscribeServiceClick(indexPath: indexPath):
        handleServiceProvidedClick(indexPath: indexPath)
    }

    private func handleServiceProvidedClick(indexPath: IndexPath) {
        if(indexPath.row == 0) {
            showRentBottomSheet()
        } else if(indexPath.row == 1) {
            showCoachingBottomSheet()
        } else if(indexPath.row == 2) {
            showGymBottomSheet()
        } else {
            showLibraryBottomSheet()
        }
    }

    private func handleSubscribeServiceClick(indexPath: IndexPath) {
        let row = indexPath.row
        var controller: UIViewController = RentViewController()
        if(row == 0) {
            controller = RentViewController()
        } else if(row == 1) {
            controller = RentViewController()
        } else if(row == 2) {
            controller = GymViewController()
        } else {
            controller = LibraryViewController()
        }
        navigationController?.pushViewController(controller, animated: true)
    }
}


extension HomeViewController: HomeDisplayLogic {

    func displayFetchUserHeader(using vm: SimpleHeaderViewModel) {
        headerView.configure(using: vm)
    }

    func displaySubscribedServices(using vm: ServiceViewModel) {

    }
}

// Bottom sheet handling
extension HomeViewController {
    
    private func showRentBottomSheet() {
        let title = ServiceConstants.rentTitle
        let subtitle = ServiceConstants.rentSubtitle
        let height = calculateBottomSheetHeight(title: title, subtitle: subtitle)
        let delegate = BottomSheetTransitionDelegate(of: .init(width: view.bounds.width, height: CGFloat(height)))
        let controller = BottomSheetViewController()
        controller.transitioningDelegate = delegate
        controller.modalPresentationStyle = .custom
        present(controller, animated: true)

        let primaryButton = BottomSheetButton(text: "Subscribe Now at ₹0") { [weak self] in
            guard let self else { return }
            interactor?.subscribeToService(service: .rent)
            // update core data about subscribed services
            // remove rent from all shown services
        }

        let vm = BottomSheetViewModel(image: ServiceConstants.rentImage, title: ServiceConstants.rentTitle, subtitle: ServiceConstants.rentSubtitle, bottomSheetAction: primaryButton)
        controller.configure(using: vm)
    }

    private func showGymBottomSheet() {
        let title = ServiceConstants.gymTitle
        let subtitle = ServiceConstants.gymSubtitle
        let height = calculateBottomSheetHeight(title: title, subtitle: subtitle)
        let delegate = BottomSheetTransitionDelegate(of: .init(width: view.bounds.width, height: CGFloat(height)))
        let controller = BottomSheetViewController()
        controller.transitioningDelegate = delegate
        controller.modalPresentationStyle = .custom
        present(controller, animated: true)

        let primaryButton = BottomSheetButton(text: "Subscribe Now at ₹0") { [weak self] in
            guard let self else { return }
            // update core data about subscribed services
            // remove rent from all shown services
            interactor?.subscribeToService(service: .gym)
        }

        let vm = BottomSheetViewModel(image: ServiceConstants.gymImage, title: title, subtitle: subtitle, bottomSheetAction: primaryButton)
        controller.configure(using: vm)
    }

    private func showCoachingBottomSheet() {
        let title = ServiceConstants.coachingTitle
        let subtitle = ServiceConstants.coachingSubtitle
        let height = calculateBottomSheetHeight(title: title, subtitle: subtitle)

        let delegate = BottomSheetTransitionDelegate(of: .init(width: view.bounds.width, height: CGFloat(height)))
        let controller = BottomSheetViewController()
        controller.transitioningDelegate = delegate
        controller.modalPresentationStyle = .custom
        present(controller, animated: true)

        let primaryButton = BottomSheetButton(text: "Subscribe Now at ₹0") { [weak self] in
            guard let self else { return }
            // update core data about subscribed services
            // remove rent from all shown services
            let controller = ViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }

        let vm = BottomSheetViewModel(image: ServiceConstants.coachingImage, title: title, subtitle: subtitle, bottomSheetAction: primaryButton)
        controller.configure(using: vm)
    }

    private func showLibraryBottomSheet() {
        let title = ServiceConstants.libraryTitle
        let subtitle = ServiceConstants.librarySubtitle
        let height = calculateBottomSheetHeight(title: title, subtitle: subtitle)
        let delegate = BottomSheetTransitionDelegate(of: .init(width: view.bounds.width, height: CGFloat(height)))
        let controller = BottomSheetViewController()
        controller.transitioningDelegate = delegate
        controller.modalPresentationStyle = .custom
        present(controller, animated: true)

        let primaryButton = BottomSheetButton(text: "Subscribe Now at ₹0") { [weak self] in
            guard let self else { return }
            // update core data about subscribed services
            // remove rent from all shown services
            let controller = LibraryViewController()
            self.navigationController?.pushViewController(controller, animated: true)
        }

        let vm = BottomSheetViewModel(image: ServiceConstants.libraryImage, title: title, subtitle: subtitle, bottomSheetAction: primaryButton)
        controller.configure(using: vm)
    }

    private func calculateBottomSheetHeight(title: String, subtitle: String) -> Int  {

        let titleWidth = view.bounds.width -
        CGFloat(BottomSheetConstant.imageWidth +
                BottomSheetConstant.imageLeading +
                BottomSheetConstant.titleLeading +
                BottomSheetConstant.titleTrailing)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: BottomSheetConstant.titleFont,
            .foregroundColor: BottomSheetConstant.titleColor
        ]

        let titleHeight = calculateHeightForText(txt: title, attributes: attributes, width: titleWidth)

        let subtitleWidth = view.bounds.width - CGFloat(
            BottomSheetConstant.subtitleLeading +
            BottomSheetConstant.subtitleTrailing
        )

        let subtitleAttributes: [NSAttributedString.Key: Any] = [
            .font: BottomSheetConstant.subtitleFont,
            .foregroundColor: BottomSheetConstant.subtitleColor
        ]
        let subtitleHeight = calculateHeightForText(txt: subtitle, attributes: subtitleAttributes, width: subtitleWidth)
        let height = BottomSheetConstant.titleTop + max(BottomSheetConstant.imageHeight, titleHeight) + BottomSheetConstant.subtitleTop + subtitleHeight + BottomSheetConstant.buttonTop + BottomSheetConstant.buttonHeight +
        40
        return height
    }
}
