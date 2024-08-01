//
//  HomeViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 23/07/24.
//

import UIKit


protocol HomeDisplayLogic: AnyObject {
    func displayFetchUserHeader(using vm: SimpleHeaderViewModel)
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

    private var membershipData: [MembershipCellData] = [
        .init(backgroundColor: .systemYellow, imageName: "house.fill"),
        .init(backgroundColor: .systemGreen, imageName: "graduationcap.fill"),
        .init(backgroundColor: .systemPink, imageName: "dumbbell.fill"),
        .init(backgroundColor: .systemBlue, imageName: "book.fill")
    ]

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        initialize()
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
        checkImage()
    }

    private func checkImage() {
        guard let url = URL(string: "") else { return }
        do {
            let data = try Data(contentsOf: url)
            print("image")
        } catch {
            print("error \(error.localizedDescription)")
        }
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
        if(collectionView == subscribedCollection) {
            let item =  indexPath.row
            if(item == 0) {
                let controller = RentViewController()
                navigationController?.pushViewController(controller, animated: true)
            } else if(item == 2) {
                let controller = GymViewController()
                navigationController?.pushViewController(controller, animated: true)
            } else if(item == 3) {
                let controller = LibraryViewController()
                navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
}


extension HomeViewController: HomeDisplayLogic {

    func displayFetchUserHeader(using vm: SimpleHeaderViewModel) {
        headerView.configure(using: vm)
    }
}
