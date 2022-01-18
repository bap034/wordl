//
//  KeyboardManager.swift
//  Wordl
//
//  Created by Brett Petersen on 1/16/22.
//

import Foundation

// Should this be a KeyboardViewModel class?
class KeyboardManager {
    static let shared = KeyboardManager()
    
    public private(set) var keys = generateTopRowKeys() + generateMidRowKeys() + generateBotRowKeys()
    var topRowKeys: [KeyboardKey] { keys.filter({ $0.rowType == .top })}
    var midRowKeys: [KeyboardKey] { keys.filter({ $0.rowType == .mid })}
    var botRowKeys: [KeyboardKey] { keys.filter({ $0.rowType == .bot })}
    
    func updateKey(keyId: String, feedbackType: KeyboardKeyFeedbackType) {
        guard let keyIndex = keys.firstIndex(where: { $0.id == keyId }) else { return }
        keys[keyIndex].feedbackType = feedbackType
    }
    func resetKeyboard() {
        keys = KeyboardManager.generateTopRowKeys() + KeyboardManager.generateMidRowKeys() + KeyboardManager.generateBotRowKeys()
    }
}

// MARK: - Key Generators
extension KeyboardManager {
    private static func generateTopRowKeys() -> [KeyboardKey] {
        let keyTypes: [KeyboardKeyType] = [.letter("q"), .letter("w"), .letter("e"), .letter("r"), .letter("t"), .letter("y"), .letter("u"), .letter("i"), .letter("o"), .letter("p")]
        let deleteKey = KeyboardKey(type: .delete, rowType: .top, feedbackType: .normal, sizeType: .dynamic)
        let keyboardKeys = generateKeys(keyTypes: keyTypes, rowType: .top) + [deleteKey]
        return keyboardKeys
    }
    private static func generateMidRowKeys() -> [KeyboardKey] {
        let keyTypes: [KeyboardKeyType] = [.letter("a"), .letter("s"), .letter("d"), .letter("f"), .letter("g"), .letter("h"), .letter("j"), .letter("k"), .letter("l")]
        let keyboardKeys = generateKeys(keyTypes: keyTypes, rowType: .mid)
        return keyboardKeys
    }
    private static func generateBotRowKeys() -> [KeyboardKey] {
        let spacerKey = KeyboardKey(type: .spacer, rowType: .bot, feedbackType: .spacer, sizeType: .dynamic)
        let submitKey = KeyboardKey(type: .submit, rowType: .bot, feedbackType: .normal, sizeType: .dynamic)
        let letterKeyTypes: [KeyboardKeyType] = [.letter("z"), .letter("x"), .letter("c"), .letter("v"), .letter("b"), .letter("n"), .letter("m")]
        let keyboardKeys = [spacerKey] + generateKeys(keyTypes: letterKeyTypes, rowType: .bot) + [submitKey]
        return keyboardKeys
    }
    private static func generateKeys(keyTypes: [KeyboardKeyType], rowType: KeyboardKeyRowType) -> [KeyboardKey] {
        let keyboardKeys = keyTypes.map({ keyType -> KeyboardKey in
            return KeyboardKey(type: keyType, rowType: rowType, feedbackType: .normal, sizeType: .fixed)
        })
        return keyboardKeys
    }
}
