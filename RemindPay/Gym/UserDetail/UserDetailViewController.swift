//
//  UserDetailViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 18/07/24.
//

import UIKit

final class UserDetailViewController: UIViewController {

    private var containerScrollView: UIScrollView!
    private var containerStackView: UIStackView!
    private var carouselView: CarouselView!
    private var pageControl: UIPageControl!
    private var containerView, separatorView: UIView!
    private var nameView, phoneView, gymJoined, planStarted, planExpiry, addressView, diseaseView, weightView, heightView, bmiView, isActiveView, paymentView
    : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(containerScrollView.contentOffset)
    }

    func configure() {

    }

    private func setup() {
        setupScrollContainer()
//        setupContainerStackView()
        setupContainer()
        setupCarousel()
        setupPageControl()
        setupSeparator()
        setupUserDetails()
    }

    private func setupScrollContainer() {
        let container = UIScrollView()
        container.backgroundColor = .white
        containerScrollView = container
        view.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: view)
        print(view.bounds.width)
    }

    private func setupContainerStackView() {
        let stackView = UIStackView()
        containerStackView = stackView
        stackView.backgroundColor = .blue
        containerScrollView.addSubview(stackView)
        stackView.setTranslatesMask()
        stackView.axis = .vertical
        stackView.pinToEdges(in: containerScrollView)
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        containerScrollView.addSubview(container)
        container.backgroundColor  = .white
        container.setTranslatesMask()
        container.pinToSafeEdges(in: containerScrollView)
    }

    private func setupCarousel() {
        let carousel = CarouselView()
        carouselView = carousel
        carousel.isUserInteractionEnabled = true
        carousel.backgroundColor = .systemCyan
        carousel.delegate = self
        containerView.addSubview(carousel)
        carousel.setTranslatesMask()
        let centerX = carousel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let top = carousel.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20)
        let width = carousel.widthAnchor.constraint(equalToConstant: 300)
        let height = carousel.heightAnchor.constraint(equalToConstant: 250)
        NSLayoutConstraint.activate([centerX, top, width, height])
        carousel.layer.cornerRadius = 20
        carousel.clipsToBounds = true
    }

    private func setupPageControl() {
        let pageControl = UIPageControl()
        self.pageControl = pageControl
        containerView.addSubview(pageControl)
        pageControl.setTranslatesMask()
        let centerX = pageControl.centerXAnchor.constraint(equalTo: carouselView.centerXAnchor)
        let top = pageControl.topAnchor.constraint(equalTo: carouselView.bottomAnchor, constant: 12)
        NSLayoutConstraint.activate([centerX, top])
        pageControl.numberOfPages = 10
        pageControl.currentPageIndicatorTintColor = .systemPink
        pageControl.pageIndicatorTintColor = .systemGray
    }

    private func setupSeparator() {
        let separator = UIView()
        separatorView = separator
        separator.backgroundColor = .lightGray
        containerView.addSubview(separator)
        separator.setTranslatesMask()
        let top = separator.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 20)
        let height = separator.heightAnchor.constraint(equalToConstant: 1)
        let width = separator.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.9)
        let centerX = separator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        NSLayoutConstraint.activate([top, height, width, centerX])
    }

    private func setupUserDetails() {
        setupName()
        setupPhone()
        setupWeight()
        setupHeight()
        setupBMI()
        setupExistingDisease()
        setupAddress()
        setupPlanStarting()
        setupPlanExpiry()
        setupGymJoining()
    }


    private func setupName() {
        let name = UILabel()
        nameView = name
        name.text = "Pranjal Agarwal"
        containerView.addSubview(name)
        name.setTranslatesMask()
        let leading = name.leadingAnchor.constraint(equalTo: carouselView.leadingAnchor)
        let top = name.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 20)
        let trailing = name.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        NSLayoutConstraint.activate([leading, top, trailing])

    }

    private func setupPhone() {
        let label = UILabel()
        phoneView = label
        label.text = "9138029345"
        containerView.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: nameView.leadingAnchor)
        let top = label.topAnchor.constraint(equalTo: nameView.bottomAnchor, constant: 12)
        let trailing = label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        NSLayoutConstraint.activate([leading, top, trailing])
    }

    private func setupWeight() {
        let label = UILabel()
        containerView.addSubview(label)
        weightView = label
        label.text = "128 kg"
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: phoneView.leadingAnchor)
        let top = label.topAnchor.constraint(equalTo: phoneView.bottomAnchor, constant: 12)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupHeight() {
        let label = UILabel()
        containerView.addSubview(label)
        heightView = label
        label.text = "180 cm"
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: weightView.trailingAnchor, constant: 12)
        let top = label.topAnchor.constraint(equalTo: weightView.topAnchor)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupBMI() {
        let label = UILabel()
        containerView.addSubview(label)
        bmiView = label
        label.text = "24"
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: heightView.trailingAnchor, constant: 12)
        let top = label.topAnchor.constraint(equalTo: weightView.topAnchor)
        let trailing = label.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        NSLayoutConstraint.activate([leading, top, trailing])
    }

    private func setupExistingDisease() {
        let label = UILabel()
        diseaseView = label
        label.numberOfLines = 0
        label.text = "Nothing"
        containerView.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: weightView.leadingAnchor)
        let top = label.topAnchor.constraint(equalTo: weightView.bottomAnchor, constant: 12)
        let trailing = label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        NSLayoutConstraint.activate([leading, top, trailing])
    }

    private func setupAddress() {
        let label = UILabel()
        addressView = label
        label.numberOfLines = 0
        label.text = "Ajmer road"
        containerView.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: diseaseView.leadingAnchor)
        let trailing = label.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let top = label.topAnchor.constraint(equalTo: diseaseView.bottomAnchor, constant: 12)
        NSLayoutConstraint.activate([leading, trailing, top])
    }

    private func setupPlanStarting() {
        let label = UILabel()
        planStarted = label
        label.numberOfLines = 0
        label.text = "18-07-2024"
        containerView.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: addressView.leadingAnchor)
        let top = label.topAnchor.constraint(equalTo: addressView.bottomAnchor, constant: 12)

        NSLayoutConstraint.activate([leading, top])
    }

    private func setupPlanExpiry() {
        let label = UILabel()
        planExpiry = label
        containerView.addSubview(label)
        label.text = "20-12-2025"
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: planStarted.trailingAnchor, constant: 12)
        let top = label.topAnchor.constraint(equalTo: planStarted.topAnchor)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupGymJoining() {
        let label = UILabel()
        gymJoined = label
        label.text = "1-04-2024"
        containerView.addSubview(label)
        label.setTranslatesMask()
        let leading = label.leadingAnchor.constraint(equalTo: planStarted.leadingAnchor)
        let top = label.topAnchor.constraint(equalTo: planStarted.bottomAnchor, constant: 12)
        NSLayoutConstraint.activate([leading, top])
    }

    private func setupPayment() {

    }

    private func setupActiveStatus() {

    }
}


extension UserDetailViewController: CarouselViewDelegate {
    func didSelectItemAtIndexPath(indexPath: IndexPath) {
        print("item selected at index path \(indexPath)")
    }
    
    func didScrollToItemAtIndexPath(indexPath: IndexPath) {
        pageControl.currentPage = indexPath.row
    }
    
    func numberOfItemsInCarousel() -> Int {
        return 10
    }
    

}
