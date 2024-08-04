import UIKit
import AVFoundation

class ViewController: UIViewController {


    @objc func showDate() {
        let controller = DatePickerController()
        controller.modalPresentationStyle = .custom

        let delegate = DateControllerTransitionDelegate()
        controller.transitioningDelegate = delegate
        present(controller, animated:  true)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        let button = UIButton()
        button.setTitle("Show date", for: .normal)
        view.addSubview(button)
        button.addTarget(self, action: #selector(showDate), for: .touchUpInside)
        button.setTranslatesMask()
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

