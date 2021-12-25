//
//  GameManager.swift
//  Wordl
//
//  Created by Brett Petersen on 12/20/21.
//

import Foundation

class GameManager {
    
    static let shared = GameManager()
    
    public private (set) var rules = Rules()
    
    public private(set) var answer: String = "Answer"
    private var customAnswer: String?
    private var gameAnswer: String { customAnswer ?? answer }
    var gameAnswerCount: Int { gameAnswer.count }
    
    private init() {
        newGame()
    }
    
}

// MARK: - Actions
extension GameManager {
    func newGame() {
        answer = GameManager.getRandomWord(rules: rules)
        customAnswer = GameManager.getCustomAnswer(answer: answer, customRules: rules.custom)
    }
    
    func guessWord(_ guess: String) -> Result<WordFeedback, ValidationError> {
        if let error = validateGuess(guess) {
            print(error.localizedDescription)
            return .failure(error)
        }
        
        let letterFeedbacks = getLetterFeedbacks(guess: guess)
        let wordFeedback = WordFeedback(word: guess, letterFeedbacks: letterFeedbacks)
        return .success(wordFeedback)
    }
    private func getLetterFeedbacks(guess: String) -> [WordFeedback.LetterFeedback] {
        var letterFeedbacks = [WordFeedback.LetterFeedback]()
        let answerLetters = Array(answer.uppercased())
        let guessLetters = Array(guess.uppercased())
        
        guard answerLetters.count == guessLetters.count else { return letterFeedbacks }
        
        guessLetters.enumerated().forEach { (index, letter) in
            let answerLetter = answerLetters[index]
            
            let feedbackType: WordFeedback.LetterFeedback.DataType
            if answerLetter == letter {
                feedbackType = .correct
            } else if answerLetters.contains(letter) {
                feedbackType = .wrongSpot
            } else {
                feedbackType = .incorrect
            }
            
            let feedback = WordFeedback.LetterFeedback(letter: String(letter), dataType: feedbackType)
            letterFeedbacks.append(feedback)
        }
        return letterFeedbacks
    }
    
    func updateRule(ruleType: Rule.RuleType?, newValue: String) {
        if ruleType == nil {
            guard let newDictionary = DictionaryType(rawValue: newValue) else { return }
            updateDictionary(newDictionary: newDictionary)
        } else if let sureRuleType = ruleType {
            switch sureRuleType {
                case .minLetters, .maxLetters:
                    guard let sureInt = Int(newValue) else { break }
                    let rule = Rule(type: sureRuleType, value: sureInt)
                    updateRules(newRule: rule)
                case .missingLast:
                    guard let sureBool = Bool(newValue) else { break }
                    let rule = Rule(type: sureRuleType, value: sureBool)
                    updateRules(newRule: rule)
            }
        }
    }
    private func updateDictionary(newDictionary: DictionaryType) {
        rules.dictionary = newDictionary
    }
    private func updateRules(newRule: Rule) {
        switch newRule.type {
            case .minLetters:
                guard let sureInt = newRule.value as? Int else { break }
                rules.minLetters = sureInt
            case .maxLetters:
                guard let sureInt = newRule.value as? Int else { break }
                rules.maxLetters = sureInt
            case .missingLast:
                guard let sureBool = newRule.value as? Bool else { break }
                rules.missingLast = sureBool
        }
    }
}

// MARK: - Answers
extension GameManager {
    /// Retrieves a random word from the `words` file.
    /// Source: https://stackoverflow.com/a/31462904
    private static func getRandomWord(rules: Rules) -> String {
        let wordLines = GameManager.getWordList(dictionaryType: rules.dictionary)
        let linesInLetterRange = wordLines.filter({ rules.minLetters...rules.maxLetters ~= $0.count })
        let singleWordLines = linesInLetterRange.filter({ !$0.contains(" ") })
        let randomIndex = Int.random(in: 0..<singleWordLines.count)
        let randomLine = singleWordLines[randomIndex]
        print(randomLine)
        return randomLine.uppercased()
    }
    
    private static func getCustomAnswer(answer: String, customRules: [Rule]) -> String? {
        guard !customRules.isEmpty else { return nil }
        
        var customAnswer = answer
        customRules.forEach { rule in
            switch rule.type {
                case .minLetters, .maxLetters:
                    break
                case .missingLast:
                    if (rule.value as? Bool) == true {
                        let missingLast = customAnswer.dropLast()
                        customAnswer = String(missingLast)
                    }
            }
        }
        return customAnswer
    }
}

// MARK: - Helper Methods
extension GameManager {
    // MARK: Validation
    enum ValidationError: Error {
        case letterMismatch
        case invalidWord
    }
    
    private func validateGuess(_ guess: String) -> ValidationError? {
        var validationError: ValidationError?
        
        if guess.count != gameAnswer.count {
            validationError = .letterMismatch
        } else if !GameDictionary.isValidWord(guess) {
            validationError = .invalidWord
        }
        
        return validationError
    }
    
    // MARK: Dictionary
    private static func getWordList(dictionaryType: DictionaryType) -> [String] {
        let wordsFilePath = Bundle.main.path(forResource: dictionaryType.rawValue, ofType: nil)
        guard let sureWordsFilePath = wordsFilePath else { return [] }
        
        do {
            let wordsString = try String(contentsOfFile: sureWordsFilePath)
            let wordLines = wordsString.components(separatedBy: .newlines)
            return wordLines
        } catch { // contentsOfFile throws an error
            print("Error: \(error)")
            return []
        }
    }
}
