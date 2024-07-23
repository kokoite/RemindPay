//
//  DashboardViewController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 22/07/24.
//

import UIKit
import DGCharts

final class DashboardViewController: UIViewController {
    private var containerScrollView: UIScrollView!
    private var containerView: UIView!
    private var header: HeaderView!
    private var monthContainer, yearlyContainer, totalContainer: UIStackView!

    private var monthContainerHeaderLabel, yearContainerHeaderLabel, totalContainerHeaderLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        view.backgroundColor = .white
        setupScrollView()
        setupContainer()
        setupHeader()
        // monthly container
        setupMonthlyContainer()
        setupMonthContainerHeader()
        setupMonthChartContainer()
        setupMonthlyGymBreakup()



        // yearly container
        setupYearlyContainer()
        setupYearContainerHeader()
        setupYearChartContainer()
        setupYearlyGymBreakup()


        // total container
        setupTotalContainer()
        setupTotalContainerHeader()
        setupTotalChartContainer()
        setupTotalGymBreakup()
    }

    private func setupScrollView() {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .cardBackground
        containerScrollView = scrollView
        view.addSubview(scrollView)
        scrollView.setTranslatesMask()
        let top = scrollView.topAnchor.constraint(equalTo: view.topAnchor)
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

    // Monthly container
    private func setupMonthlyContainer() {
        let container = UIStackView()
        container.axis = .vertical
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        container.backgroundColor = .white
        container.layer.cornerRadius = 20
        container.clipsToBounds = true
        monthContainer = container
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailng = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: header.bottomAnchor, constant: 40)
        NSLayoutConstraint.activate([leading, top, trailng])
    }

    private func setupMonthContainerHeader() {
        let label = UILabel()
        monthContainerHeaderLabel = label
        label.text = "Monthly revenue"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        monthContainer.addArrangedSubview(label)
    }

    private func setupMonthChartContainer() {

        let chartView = PieChartView()
        chartView.rotationEnabled = false
        chartView.backgroundColor = .white
        let entries = [PieChartDataEntry(value: 1000, label: "Plan renewed"), PieChartDataEntry(value: 2000, label: "New joiners")]
        let dataset = PieChartDataSet(entries: entries)
        dataset.colors = [.systemBlue, .systemPink]
        dataset.highlightColor = .black
        dataset.entryLabelFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        dataset.entryLabelColor = UIColor.black.withAlphaComponent(0.8)
        dataset.sliceSpace = 8
        dataset.xValuePosition = .insideSlice
        let data = PieChartData(dataSet: dataset)
        chartView.data = data
        let centerTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold), .foregroundColor: UIColor.black]
        let centerText = "Monthly revenue"
        chartView.centerAttributedText = NSAttributedString(string: centerText, attributes: centerTextAttributes)
        chartView.legend.enabled = false
        monthContainer.addArrangedSubview(chartView)
        chartView.setTranslatesMask()
        let height = chartView.heightAnchor.constraint(equalToConstant: 250)

        NSLayoutConstraint.activate([height])
    }

    private func setupMonthlyGymBreakup() {
        let gymView = GymBreakupView()
        monthContainer.addArrangedSubview(gymView)
        gymView.setTranslatesMask()
        let height = gymView.heightAnchor.constraint(equalToConstant: 180)
        NSLayoutConstraint.activate([height])
    }

    // Yearly Container
    private func setupYearlyContainer() {
        let container = UIStackView()
        container.axis = .vertical
        container.isLayoutMarginsRelativeArrangement = true
        container.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        container.backgroundColor = .white
        container.layer.cornerRadius = 20
        container.clipsToBounds = true
        yearlyContainer = container
        containerView.addSubview(container)
        container.setTranslatesMask()
        let leading = container.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20)
        let trailng = container.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        let top = container.topAnchor.constraint(equalTo: monthContainer.bottomAnchor, constant: 40)
        let bottom = container.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([leading, top, trailng, bottom])
    }

    private func setupYearContainerHeader() {
        let label = UILabel()
        yearContainerHeaderLabel = label
        label.text = "Yearly revenue"
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .lightGray
        yearlyContainer.addArrangedSubview(label)
    }

    private func setupYearChartContainer() {

        let chartView = PieChartView()
        chartView.rotationEnabled = false
        chartView.backgroundColor = .white
        let entries = [PieChartDataEntry(value: 1000, label: "Plan renewed"), PieChartDataEntry(value: 2000, label: "New joiners")]
        let dataset = PieChartDataSet(entries: entries)
        dataset.colors = [.systemBlue, .systemCyan]
        dataset.highlightColor = .black
        dataset.entryLabelFont = UIFont.systemFont(ofSize: 16, weight: .bold)
        dataset.entryLabelColor = UIColor.black.withAlphaComponent(0.8)
        dataset.sliceSpace = 8
        dataset.xValuePosition = .insideSlice
        let data = PieChartData(dataSet: dataset)
        chartView.data = data
        let centerTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .bold), .foregroundColor: UIColor.black]
        let centerText = "Monthly revenue"
        chartView.centerAttributedText = NSAttributedString(string: centerText, attributes: centerTextAttributes)
        chartView.legend.enabled = false
        yearlyContainer.addArrangedSubview(chartView)
        chartView.setTranslatesMask()
        let height = chartView.heightAnchor.constraint(equalToConstant: 250)

        NSLayoutConstraint.activate([height])
    }


    private func setupYearlyGymBreakup() {
        let gymView = GymBreakupView()
        yearlyContainer.addArrangedSubview(gymView)
        gymView.setTranslatesMask()
        let height = gymView.heightAnchor.constraint(equalToConstant: 180)
        NSLayoutConstraint.activate([height])
    }


    // Total 
    private func setupTotalContainer() {

    }

    private func setupTotalContainerHeader() {

    }

    private func setupTotalChartContainer() {

    }
    private func setupTotalGymBreakup() {

    }
}
