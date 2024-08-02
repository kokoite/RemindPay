//
//  Utility.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 31/07/24.
//

import Foundation
import UIKit

func getTodaysDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd-MM-yyyy"
    return formatter.string(from: date)
}

func getDocumentDirectory() -> URL {
    let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return path[0]
}

func deleteFileAtUrl(url: URL) {
    do {
        try FileManager.default.removeItem(at: url)
    } catch (let error) {
        print("error \(error.localizedDescription)")
    }
}

func deleteImage(filename: String) {
    let document = getDocumentDirectory()
    let filePath = document.appendingPathComponent(filename)
    do {
        try FileManager.default.removeItem(at: filePath)
    } catch(let error) {
        print("error \(error.localizedDescription)")
    }
}

func getImageFrom(fileName: String) throws -> UIImage? {
    let documents = getDocumentDirectory()
    let filePath = documents.appendingPathComponent(fileName)
    do {
        let image = try Data(contentsOf: filePath)
        return UIImage(data: image)
    } catch(let error) {
        print("error \(error.localizedDescription)")
        throw error
    }
}

func calculateHeightForText(txt: String, attributes: [NSAttributedString.Key: Any], width: CGFloat) -> Int {

    let text = NSString(string: txt)
    let rect = text.boundingRect(with: .init(width: width, height: .greatestFiniteMagnitude), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: attributes, context: nil)
    return Int(rect.height + 1)/1
}
