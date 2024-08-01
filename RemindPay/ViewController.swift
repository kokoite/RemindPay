import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Add a button to open the camera
        let openCameraButton = UIButton(type: .system)
        openCameraButton.setTitle("Open Camera", for: .normal)
        openCameraButton.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        openCameraButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(openCameraButton)

        // Center the button in the view
        NSLayoutConstraint.activate([
            openCameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            openCameraButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    @objc func openCamera() {
        // Check if the device has a camera
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            if status == .authorized {
                // Open the camera
                presentCamera()
            } else if status == .notDetermined {
                // Request camera access
                AVCaptureDevice.requestAccess(for: .video) { granted in
                    if granted {
                        DispatchQueue.main.async {
                            self.presentCamera()
                        }
                    } else {
                        // Handle denied access
                        self.showPermissionDeniedAlert()
                    }
                }
            } else {
                // Handle denied or restricted access
                showPermissionDeniedAlert()
            }
        } else {
            // Handle device without a camera
            showNoCameraAlert()
        }
    }

    func presentCamera() {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true // Set to false if you don't need editing
        present(imagePickerController, animated: true, completion: nil)
    }

    func showPermissionDeniedAlert() {
        let alert = UIAlertController(title: "Camera Access Denied", message: "Please enable camera access in Settings.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func showNoCameraAlert() {
        let alert = UIAlertController(title: "No Camera", message: "This device has no camera.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[.editedImage] as? UIImage {
            print(editedImage)
        } else if let originalImage = info[.originalImage] as? UIImage {
            // Do something with the original image
            print(originalImage)
        }
        dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

