//
//  ImageManager.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 03/08/24.
//

import UIKit


protocol ImageManagerDelelgate: AnyObject {
    func didSaveImageToDocument(filename: String?, error: Error?)
    func didSaveImagesToDocument(fileNames: [String], error: Error?)
    func didDeleteImageFromDocument(error: Error?)
    func didDeleteImagesFromDocument(error: Error?)
}


protocol SingleImageManagerDelelgate: AnyObject {
    func didSaveImageToDocument(filename: String?, error: Error?)
    func didDeleteImageFromDocument(error: Error?)
}

protocol MultipleImageManagerDelelgate: AnyObject {

    func didSaveImagesToDocument(fileNames: [String], error: Error?)

    func didDeleteImagesFromDocument(error: Error?)
}

final class ImageManager {
    
    static let instance = ImageManager()

    private init() { }

    weak var singleImageDelegate: SingleImageManagerDelelgate?

    weak var multipleImageDelegate: MultipleImageManagerDelelgate?



    func saveImagesToDocuments(images: [UIImage]) {
        Task {
            do {
                let result = try await withThrowingTaskGroup(of: String.self) { group in
                    var result: [String] = []
                    for image in images {

                        group.addTask {
                            let documentDirectory = getDocumentDirectory()
                            let fileName = UUID().uuidString + ".jpg"
                            let jpeg = image.jpegData(compressionQuality: 0.7)
                            let filePath = documentDirectory.appendingPathComponent(fileName)
                            do {
                                try jpeg?.write(to: filePath)
                            } catch (let error) {
                                print("Error \(error.localizedDescription)")
                                throw error
                            }

                            return fileName
                        }
                    }
                    for try await name in group {
                        result.append(name)
                    }
                    return result
                }
                multipleImageDelegate?.didSaveImagesToDocument(fileNames: result, error: nil)
            } catch let error {
                multipleImageDelegate?.didSaveImagesToDocument(fileNames: [], error: error)
            }
        }
    }

    func saveImageToDocuments(image: UIImage) {
        Task {
            do {
                let document = getDocumentDirectory()
                let filename = UUID().uuidString + ".jpg"
                let filepath = document.appending(path: filename, directoryHint: .notDirectory)
                let jpeg = image.jpegData(compressionQuality: 0.7)
                try jpeg?.write(to: filepath)
                DispatchQueue.main.async {
                    self.singleImageDelegate?.didSaveImageToDocument(filename: filename, error: nil)
                }
            } catch (let error) {
                print("Error \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.singleImageDelegate?.didSaveImageToDocument(filename: nil, error: error)
                }
            }
        }
    }


    func deleteImageFromDocuments(filename: String) {
        Task {
            do {
                let document = getDocumentDirectory()
                let filepath = document.appending(path: filename, directoryHint: .notDirectory)
                try FileManager.default.removeItem(at: filepath)
                DispatchQueue.main.async {
                    self.singleImageDelegate?.didDeleteImageFromDocument(error: nil)
                }

            } catch let error {
                print("Error \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.singleImageDelegate?.didDeleteImageFromDocument(error: error)
                }
            }
        }
    }





    func deleteImagesFromDocuments(filenames: [String]) {
        Task {
            do {
                try await withThrowingTaskGroup(of: Void.self) { group in
                    for image in filenames {
                        group.addTask {
                            let document = getDocumentDirectory()
                            let filepath = document.appendingPathComponent(image)
                            try FileManager.default.removeItem(at: filepath)

                        }

                        try await group.next()
                    }
                }
                multipleImageDelegate?.didDeleteImagesFromDocument(error: nil)
            } catch let error {
                print("Error \(error.localizedDescription)")
                multipleImageDelegate?.didDeleteImagesFromDocument(error: error)
            }
        }
    }

    func saveImages(images: [UIImage]) async throws -> [String] {

        return try await withThrowingTaskGroup(of: String.self) { group in
            var result: [String] = []
            for image in images {

                group.addTask {
                    let documentDirectory = getDocumentDirectory()
                    let fileName = UUID().uuidString + ".jpg"
                    let jpeg = image.jpegData(compressionQuality: 0.7)
                    let filePath = documentDirectory.appendingPathComponent(fileName)
                    try jpeg?.write(to: filePath)
                    return fileName
                }
            }
            for try await name in group {
                result.append(name)
            }
            return result
        }
    }

    func saveImage(image: UIImage) async throws -> String {
        let document = getDocumentDirectory()
        let filename = UUID().uuidString + ".jpg"
        let filepath = document.appending(path: filename, directoryHint: .notDirectory)
        let jpeg = image.jpegData(compressionQuality: 0.7)
        try jpeg?.write(to: filepath)
        return filename
    }

    func deleteImage(image: String)  {
        Task {
            let document = getDocumentDirectory()
            let filepath = document.appending(path: image, directoryHint: .notDirectory)
            try FileManager.default.removeItem(at: filepath)
        }
    }

    func deleteImages(images: [String]) {
        Task {
            do {
                await withThrowingTaskGroup(of: Void.self) { group in
                    for image in images {
                        group.addTask {
                            let document = getDocumentDirectory()
                            let filepath = document.appendingPathComponent(image)
                            try FileManager.default.removeItem(at: filepath)
                        }
                    }
                }
            }
        }
    }
}
