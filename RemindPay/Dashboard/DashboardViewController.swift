//
//  DashboardViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 22/07/24.
//

import UIKit
import SwiftUI

final class DashboardViewController: UIViewController {
    private var containerScrollView: UIScrollView!
    fileprivate var containerView: UIView!
    private var header: HeaderView!
    private var monthContainer, yearlyContainer, totalContainer: UIStackView!
    fileprivate var dashboardContainer, gymContainer, gymMonthlyContainer, gymYearlyContainer, gymTotalContainer: UIStackView!

    private var monthContainerHeaderLabel, yearContainerHeaderLabel, totalContainerHeaderLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(containerScrollView.contentOffset)
        containerScrollView.contentOffset = .zero
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(containerScrollView.contentOffset)
    }

    private func setup() {
        view.backgroundColor = .cardBackground
        setupScrollView()
        setupContainer()
        setupHeader()
        setupDashboardContainer()


        // gym
        setupGymContainer()
        setupGymMonthlyContainer()
        setupGymMonthlyTitle()
        setupGymMonthlyChartView()
        setupGymMonthlyBreakup()

        setupGymYearlyView()
        setupGymYearlyTitle()
        setupGymYearlyChartView()
        setupGymYearlyBreakupView()


        // yearly
        setupGymTotalContainer()
        setupGymTotalTitle()
        setupGymTotalChartView()
        setupGymTotalBreakupView()
    }

    private func setupScrollView() {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .cardBackground
        containerScrollView = scrollView
        view.addSubview(scrollView)
        scrollView.setTranslatesMask()
        let top = scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        let bottom = scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        let leading = scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        NSLayoutConstraint.activate([top, bottom, leading, trailing])
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        container.backgroundColor = .cardBackground
        containerScrollView.addSubview(container)
        container.setTranslatesMask()
        container.pinToEdges(in: containerScrollView)
        container.widthAnchor.constraint(equalTo: containerScrollView.widthAnchor).isActive = true
    }

    // Header
    private func setupHeader() {
        let header = HeaderView()
        self.header = header
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

    private func setupDashboardContainer() {
        let container = UIStackView()
        container.axis = .vertical
        dashboardContainer = container
        containerView.addSubview(container)
        container.backgroundColor = .cardBackground
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 0, left: 20, bottom: 0, right: 20)
        container.layer.cornerRadius = 12
        container.clipsToBounds = true
        container.setTranslatesMask()
        let top = container.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 20)
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        let trailng = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        NSLayoutConstraint.activate([top, leading, trailng])
    }

    deinit {
        print("Dashboard deinit")
    }
}

// Gym View
extension DashboardViewController {

    fileprivate func setupGymContainer() {
        let container = UIStackView()
        gymContainer = container
        container.axis = .vertical
        container.spacing = 40
        container.clipsToBounds = true
        container.layer.cornerRadius = 12
        container.backgroundColor = .cardBackground
        dashboardContainer.addArrangedSubview(container)
    }

    fileprivate func setupGymMonthlyContainer() {
        let container = UIStackView()
        gymMonthlyContainer = container
        container.backgroundColor = .white
        gymContainer.addArrangedSubview(container)
        container.axis = .vertical
        container.spacing = 20
        container.layer.cornerRadius = 12
        container.clipsToBounds = true
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
    }

    fileprivate func setupGymMonthlyTitle() {
        let label = UILabel()
        label.text = "Gym monthly revenue"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        gymMonthlyContainer.addArrangedSubview(label)
    }

    fileprivate func setupGymMonthlyChartView() {
        let chart = PieChart()
        let controller = UIHostingController(rootView: chart)
        addChild(controller)
        controller.view.setTranslatesMask()
        gymMonthlyContainer.addArrangedSubview(controller.view)
        controller.didMove(toParent: self)
    }

    fileprivate func setupGymMonthlyBreakup() {
        let container = GymBreakupView()
        gymMonthlyContainer.addArrangedSubview(container)
        container.setTranslatesMask()
        container.bottomAnchor.constraint(equalTo: gymMonthlyContainer.bottomAnchor, constant: -12).isActive = true
    }

    fileprivate func setupGymYearlyView() {
        let container = UIStackView()
        gymYearlyContainer = container
        container.backgroundColor = .white
        container.axis = .vertical
        container.spacing = 12
        container.layer.cornerRadius = 12
        container.clipsToBounds = true
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
        gymContainer.addArrangedSubview(container)
    }

    fileprivate func setupGymYearlyTitle() {
        let label = UILabel()
        label.text = "Gym yearly revenue"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        gymYearlyContainer.addArrangedSubview(label)
    }

    fileprivate func setupGymYearlyChartView() {
        let barChart = BarChart()
        let controller = UIHostingController(rootView: barChart)
        addChild(controller)
        controller.didMove(toParent: self)
        gymYearlyContainer.addArrangedSubview(controller.view)
    }

    fileprivate func setupGymYearlyBreakupView() {
        let container = GymBreakupView()
        gymYearlyContainer.addArrangedSubview(container)
        container.setTranslatesMask()
        container.bottomAnchor.constraint(equalTo: gymYearlyContainer.bottomAnchor, constant: -12).isActive = true
    }


    fileprivate func setupGymTotalContainer() {
        let container = UIStackView()
        container.backgroundColor = .white
        gymTotalContainer = container
        gymContainer.addArrangedSubview(container)
        container.axis = .vertical
        container.spacing = 20
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = .init(top: 12, left: 12, bottom: 12, right: 12)
    }

    fileprivate func setupGymTotalTitle() {
        let label = UILabel()
        label.text = "Gym revenue till today"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        gymTotalContainer.addArrangedSubview(label)
    }

    fileprivate func setupGymTotalChartView() {
        let chart = BarChart()
        let controller = UIHostingController(rootView: chart)
        addChild(controller)
        controller.view.setTranslatesMask()
        gymTotalContainer.addArrangedSubview(controller.view)
        controller.didMove(toParent: self)
    }

    fileprivate func setupGymTotalBreakupView() {
        let container = GymBreakupView()
        gymTotalContainer.addArrangedSubview(container)
        container.setTranslatesMask()
        container.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20).isActive = true
    }
}
