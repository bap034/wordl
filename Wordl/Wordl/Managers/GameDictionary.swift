//
//  GameDictionary.swift
//  Wordl
//
//  Created by Brett Petersen on 12/20/21.
//

import Foundation
import UIKit

class GameDictionary {
    
    /// Source: https://www.hackingwithswift.com/books/ios-swiftui/validating-words-with-uitextchecker
    static func isValidWord(_ word: String) -> Bool {
        let textChecker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = textChecker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        let isValid = misspelledRange.location == NSNotFound
        return isValid
    }
    
}
