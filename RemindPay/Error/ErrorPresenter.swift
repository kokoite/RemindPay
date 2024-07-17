//
//  ErrorPresenter.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 17/07/24.
//

protocol ErrorPresenter {
    func showError()
    func dismiss()
    var dismissBlock: ((_ cancelled: Bool) -> Void)? { get set }
    func dismissWithCompletion(completion: @escaping ()->Void)
}

extension ErrorPresenter {
    func dismissWithCompletion(completion: @escaping () -> Void) { }
}

protocol ErrorUI {
    init(using viewModel: ErrorViewModel, and presenter: ErrorPresenter)
}
