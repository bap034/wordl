//
//  KeyboardKey.swift
//  Wordl
//
//  Created by Brett Petersen on 1/2/22.
//

import Foundation

enum KeyboardKeyType {
    case delete
    case letter(String)
    case submit
    case spacer
    
    var displayText: String {
        switch self {
            case .letter(let value):
                return value.uppercased()
            case .submit:
                return "☺︎"
            case .delete:
                return "⌫"
            case .spacer:
                return ""
        }
    }
}

enum KeyboardKeyRowType {
    case top
    case mid
    case bot
}

enum KeyboardKeyFeedbackType {
    case spacer
    case normal
    case unused
    case wrongSpot
    case correct
    
    init(letterFeedbackType: WordFeedback.LetterFeedback.DataType) {
        switch letterFeedbackType {
            case .correct:
                self = .correct
            case .incorrect:
                self = .unused
            case .wrongSpot:
                self = .wrongSpot            
        }
    }
}
enum KeyboardKeySizeType {
    case fixed
    case dynamic
}

struct KeyboardKey: Identifiable {
    let type: KeyboardKeyType
    let rowType: KeyboardKeyRowType
    var feedbackType: KeyboardKeyFeedbackType
    let sizeType: KeyboardKeySizeType
    
    var id: String { type.displayText }
}
