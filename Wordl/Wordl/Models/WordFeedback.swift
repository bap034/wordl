//
//  WordFeedback.swift
//  Wordl
//
//  Created by Brett Petersen on 12/20/21.
//

import Foundation

struct WordFeedback: Identifiable {
    struct LetterFeedback: Identifiable {
        enum DataType {
            case correct
            case wrongSpot
            case incorrect
        }
        
        let id = UUID()
        let letter: String
        let dataType: DataType
    }
    
    let id = UUID()
    let word: String
    let letterFeedbacks: [LetterFeedback]
}
