//
//  ArrayOfStringTransformer.swift
//  RemindPay
//
//  Created by Pranjal Agarwal on 02/08/24.
//

import Foundation
import CoreData

@objc(ArrayOfStringTransformer)
final class ArrayOfStringTransformer: ValueTransformer {

    static func register() {
        let transformer = ArrayOfStringTransformer()
        ValueTransformer.setValueTransformer(transformer, forName: NSValueTransformerName(rawValue: String(describing: ArrayOfStringTransformer.self)))
    }

    override class func transformedValueClass() -> AnyClass {
        return NSData.self
    }

    override class func allowsReverseTransformation() -> Bool {
        return true
    }

    override func transformedValue(_ value: Any?) -> Any? {
        guard let stringArray = value as? [String] else { return nil }

        do {
            let data = try JSONEncoder().encode(stringArray)
            return data
        } catch {
            print("Error encoding array: \(error.localizedDescription)")
            return nil
        }
    }

    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else { return nil }

        do {
            let stringArray = try JSONDecoder().decode([String].self, from: data)
            return stringArray
        } catch {
            print("Error decoding array: \(error.localizedDescription)")
            return nil
        }
    }
}


