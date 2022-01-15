//
//  KeyboardKey.swift
//  Wordl
//
//  Created by Brett Petersen on 1/2/22.
//

import Foundation

enum KeyboardKeyFeedbackType {
    case normal
    case unused
    case wrongSpot
    case correct
}
enum KeyboardKeySizeType {
    case fixed
    case dynamic
}

struct KeyboardKey: Identifiable {
    let value: String
    var feedbackType: KeyboardKeyFeedbackType
    let sizeType: KeyboardKeySizeType
    
    var id: String { value }
}

class KeyboardManager {
    static func generateTopRowKeys() -> [KeyboardKey] {
        let keyStrings = ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"]
        let keyboardKeys = generateKeys(keyStrings: keyStrings)
        return keyboardKeys
    }
    static func generateMidRowKeys() -> [KeyboardKey] {
        let keyStrings = ["A", "S", "D", "F", "G", "H", "J", "K", "L"]
        let keyboardKeys = generateKeys(keyStrings: keyStrings)
        return keyboardKeys
    }
    static func generateBotRowKeys() -> [KeyboardKey] {
        let deleteKey = KeyboardKey(value: "⌫", feedbackType: .normal, sizeType: .dynamic)
        let submitKey = KeyboardKey(value: "⇪", feedbackType: .normal, sizeType: .dynamic)
        let letterKeyStrings = ["Z", "X", "C", "V", "B", "N", "M"]
        let keyboardKeys = [deleteKey] + generateKeys(keyStrings: letterKeyStrings) + [submitKey]
        return keyboardKeys
    }
    static func generateKeys(keyStrings: [String]) -> [KeyboardKey] {
        let keyboardKeys = keyStrings.map({ keyString -> KeyboardKey in
            return KeyboardKey(value: keyString, feedbackType: .normal, sizeType: .fixed)
        })
        return keyboardKeys
    }
}
