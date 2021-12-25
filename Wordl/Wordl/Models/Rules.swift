//
//  Rules.swift
//  Wordl
//
//  Created by Brett Petersen on 12/20/21.
//

import Foundation

struct Rules {
    static let defaultMinLettersValue = 4
    static let defaultMaxLettersValue = 9
    static let defaultMissingLast = false
    
    var dictionary = DictionaryType.oxford3000
    
    var minLetters = defaultMinLettersValue
    var maxLetters = defaultMaxLettersValue
    
    var missingLast = defaultMissingLast
    var custom: [Rule] { [Rule(type: .missingLast, value: missingLast)] }
}
