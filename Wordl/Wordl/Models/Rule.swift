//
//  Rule.swift
//  Wordl
//
//  Created by Brett Petersen on 12/24/21.
//

import Foundation

// TODO: pluralization and past tense words?
enum DictionaryType: String, CaseIterable {
    case oxford3000 = "oxford-3000"
    case names = "propernames"
    case macOSWordList = "words"
    
    var titleText: String {
        switch self {
            case .oxford3000: return "Oxford 3000"
            case .names: return "Names"
            case .macOSWordList: return "Mac Word List"
        }
    }
    var descriptionText: String {
        switch self {
            case .oxford3000: return "The Oxford 3000 is a list of the 3000 most important words to learn in English."
            case .names: return "A list of people's names."
            case .macOSWordList: return "A really large list of words used by the Mac software."
        }
    }
}

struct Rule {
    enum RuleType: CaseIterable {
        case minLetters
        case maxLetters
        case missingLast
        
        var titleText: String {
            switch self {
                case .minLetters:   return "Minimum word length"
                case .maxLetters:   return "Maximum word length"
                case .missingLast:  return "Drop the last letter"
            }
        }
        var descriptionText: String? {
            switch self {
                case .minLetters:   return nil
                case .maxLetters:   return nil
                case .missingLast:  return "Play with the designated word length, but with the last letter missing. For example: if the answer is \"POTATO\", then you will be playing with the word \"POTAT\"."
            }
        }
    }
    
    let type: RuleType
    let value: Any
}
