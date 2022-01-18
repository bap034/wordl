//
//  MainViewModel.swift
//  Wordl
//
//  Created by Brett Petersen on 12/17/21.
//

import Combine
import Foundation
import SwiftUI

class MainViewModel: ObservableObject {

    @Published public private(set) var guessedWords = [WordFeedback]()
    @Published public private(set) var showSettings = false
    @Published public private(set) var enteredText = ""
    @Published public private(set) var keyboard: [KeyboardKey]
    @Published public private(set) var alertText = ""
    
    var answerText: String { manager.answer }
    var helperText: String { "Guess the \(GameManager.shared.gameAnswerCount)-word" }
    private var manager: GameManager
    private var keyboardManager: KeyboardManager
        
    init(manager: GameManager = GameManager.shared, keyboardManager: KeyboardManager = KeyboardManager.shared) {
        self.manager = manager
        self.keyboardManager = keyboardManager
        keyboard = keyboardManager.keys
    }
    
    private func submitGuess(newText: String) {
        let result = manager.guessWord(newText)
        switch result {
            case .success(let wordFeedback):
                guessedWords.insert(wordFeedback, at: 0)
                updateKeyboardFeedback(wordFeedback: wordFeedback)
                enteredText = ""
                alertText = ""
            case .failure(let error):
                alertText = error.localizedDescription
        }
    }
    private func updateKeyboardFeedback(wordFeedback: WordFeedback) {
        wordFeedback.letterFeedbacks.forEach { letterFeedback in
            let keyId = letterFeedback.letter.uppercased()
            let feedbackType = KeyboardKeyFeedbackType(letterFeedbackType: letterFeedback.dataType)
            keyboardManager.updateKey(keyId: keyId, feedbackType: feedbackType)
        }
        keyboard = keyboardManager.keys
    }
    private func resetKeyboardFeedback() {
        keyboardManager.resetKeyboard()
        keyboard = keyboardManager.keys
    }
}

// MARK: - View Triggered Events
extension MainViewModel {
    func onKeyTapped(key: KeyboardKey) {
        switch key.type {
            case .letter(_):
                enteredText += key.type.displayText
            case .submit:
                submitGuess(newText: enteredText)
            case .delete:
                enteredText = String(enteredText.dropLast())
            case .spacer:
                break
        }
    }
    func onNewGameTapped() {
        manager.newGame()
        resetKeyboardFeedback()
        guessedWords = []
        enteredText = ""
        alertText = ""
    }
}
