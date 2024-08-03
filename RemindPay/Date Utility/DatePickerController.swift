//
//  DatePickerController.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 31/07/24.
//

import UIKit


protocol DatePickerDelegate: AnyObject {
    func didSelect(date: Date)
    func didDismiss(date: Date)
}


final class DatePickerController: UIViewController, UIGestureRecognizerDelegate {
    private var containerView: UIView!
    private var datePicker: UIDatePicker!
    weak var delegate: DatePickerDelegate?
    let utility = DateUtility.instance
    var action: ((_ selectedDate: String)->Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    @objc func containerClicked(_ sender: UITapGestureRecognizer) {
        delegate?.didDismiss(date: datePicker.date)
        delegate = nil
        let date = utility.getDate(for: datePicker.date)
        action?(date)
        view.removeFromSuperview()
        removeFromParent()
    }

    @objc func dateSelected() {
        delegate?.didSelect(date: datePicker.date)
        let date = utility.getDate(for: datePicker.date)
//        action?(date)
//        view.removeFromSuperview()
//        removeFromParent()
    }

    private func setup() {
        setupContainer()
        setupDatePicker()
    }

    private func setupContainer() {
        let container = UIView()
        containerView = container
        view.addSubview(container)
        container.setTranslatesMask()
        container.backgroundColor = .black.withAlphaComponent(0.7)
        container.pinToEdges(in: view)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(containerClicked))
        gesture.delegate = self
        container.addGestureRecognizer(gesture)
    }

    private func setupDatePicker() {
        let picker = UIDatePicker()
        datePicker = picker
        picker.tintColor = .systemPink
        picker.date = Date()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .inline
        picker.setValue(UIColor.white, forKey: "backgroundColor")
        containerView.addSubview(picker)
        picker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
        picker.setTranslatesMask()
        picker.layer.cornerRadius = 12
        picker.clipsToBounds = true
        let centerX = picker.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        let centerY = picker.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        NSLayoutConstraint.activate([centerX, centerY])
    }

    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        let location = touch.location(in: containerView)
        return !datePicker.frame.contains(location)
    }
}



