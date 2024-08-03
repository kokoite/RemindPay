//
//  ImageManager.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 03/08/24.
//

import UIKit


final class ImageManager {
    
    static let instance = ImageManager()

    private init() { }


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
